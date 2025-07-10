//
//  ImageListView.swift
//  ImageListPresentation
//
//  Created by Taemin Yun on 2025-07-07.
//

import SwiftUI

import Kingfisher

import AppError
import ImageListDomain

public struct ImageListView: View {
    
    @ObservedObject private var viewModel: ImageListViewModel
    @State private var errorDTO: ErrorDTO?
    
    public init(repository: ImageListRepository) {
        self.viewModel = ImageListViewModel(
            repository: repository
        )
    }
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.images, id: \.self) { image in
                    HStack {
                        KFImage(URL(string: image.url))
                            .placeholder { ProgressView() }
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        
                        Text("by \(image.author)")
                    }
                }
                .onDelete { offsets in
                    handleAppError {
                        try await viewModel.removeImage(atOffsets: offsets)
                    }
                }
                .onMove { source, destination in
                    handleAppError {
                        try await viewModel.moveImage(fromOffsets: source, toOffset: destination)
                    }
                }
            }
            .navigationTitle("Taemin's Image List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        handleAppError(viewModel.add)
                    }) {
                        Text("Add Image")
                    }
                }
            }
            .alert(item: $errorDTO) { error in
                let title = Text("Error")
                let message = Text(error.message)
                let dissmissButton = Alert.Button.default(Text("OK"))
                
                if let retryAction = error.retryAction {
                    return Alert(
                        title: title,
                        message: message,
                        primaryButton: dissmissButton,
                        secondaryButton: .default(Text("Retry")) {
                            handleAppError(needRetry: true, retryAction)
                        }
                    )
                } else {
                    return Alert(title: title, message: message, dismissButton: dissmissButton)
                }
            }
        }
        .task {
            await handleAppError(needRetry: true, viewModel.fetch)
        }
    }
}

// MARK: - Error Helper
private extension ImageListView {
    struct ErrorDTO: Identifiable {
        var id = UUID()
        var message: String
        var retryAction: (() async throws -> Void)?
        
        init(message: String, retryAction: (() async throws -> Void)?) {
            self.message = message
            self.retryAction = retryAction
        }
    }
    
    func handleAppError(
        needRetry: Bool,
        _ action: @escaping () async throws -> Void
    ) async {
        do {
            try await action()
        } catch let error as AppErrorMakable {
            errorDTO = ErrorDTO(message: error.message, retryAction: needRetry ? action : nil)
        } catch {
            errorDTO = ErrorDTO(message: "An unexpected error occurred.", retryAction: nil)
        }
    }
    
    func handleAppError(
        needRetry: Bool = false,
        _ action: @escaping () async throws -> Void
    ) {
        Task { await handleAppError(needRetry: needRetry, action) }
    }
}


// MARK: - Preview
#Preview {
    struct MockImageListRepository: ImageListRepository {
        func fetchedImages() async throws -> [ImageEntity] {
            [
                ImageEntity(id: "123", url: "https://x.com", author: "apple"),
                ImageEntity(id: "456", url: "https://y.com", author: "book"),
                ImageEntity(id: "789", url: "https://z.com", author: "cat")
            ]
        }
    }
    
    return ImageListView(repository: MockImageListRepository())
}
