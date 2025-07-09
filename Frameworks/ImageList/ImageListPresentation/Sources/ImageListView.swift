//
//  ImageListView.swift
//  ImageListPresentation
//
//  Created by Taemin Yun on 2025-07-07.
//

import SwiftUI
import ImageListDomain
import Kingfisher

public struct ImageListView: View {
    @ObservedObject var viewModel: ImageListViewModel
    
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
                    Task {
                        try await viewModel.removeImage(atOffsets: offsets)
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
                        Task { try await viewModel.add() }
                    }) {
                        Text("Add Image")
                    }
                }
            }
        }
        .task {
            do {
                try await viewModel.fetch()
            } catch {
                // TODO: Handle error
                print(error)
            }
        }
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
