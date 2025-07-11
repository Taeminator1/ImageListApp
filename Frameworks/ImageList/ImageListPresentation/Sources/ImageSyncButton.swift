//
//  ImageSyncButton.swift
//  ImageListPresentation
//
//  Created by Taemin Yun on 2025-07-10.
//

import SwiftUI

struct ImageSyncButton: View {
    
    @Binding private var isProcessing: Bool
    private let cachedImagesLoaded: Bool
    private let onSync: () async -> Void
    @State private var showAlert = false
    
    init(
        isProcessing: Binding<Bool>,
        cachedImagesLoaded: Bool,
        onSync: @escaping () async -> Void
    ) {
        _isProcessing = isProcessing
        self.cachedImagesLoaded = cachedImagesLoaded
        self.onSync = onSync
    }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: buttonImageName)
                        .font(.system(size: 48))
                        .foregroundStyle(isProcessing ? .gray : .blue)
                        .padding()
                }
                .disabled(isProcessing)
                .buttonStyle(NoAnimationButtonStyle())
                .padding(.bottom, -24)
                .alert(
                    Text(alertTitle),
                    isPresented: $showAlert,
                    actions: {
                        Button("Cancel", role: .cancel) { }
                        Button("Confirm") {
                            Task {
                                guard !isProcessing else { return }
                                await MainActor.run { isProcessing = true }
                                await onSync()
                                await MainActor.run { isProcessing = false }
                            }
                        }
                    },
                    message: { Text(alertMessage) }
                )
            }
        }
    }
}

private extension ImageSyncButton {
    var buttonImageName: String {
        cachedImagesLoaded ? "trash.circle.fill" : "arrow.down.circle"
    }
    
    var alertTitle: String {
        cachedImagesLoaded ? "Clear Saved Images" : "Fetch & Save"
    }
    
    var alertMessage: String {
        cachedImagesLoaded ?
        "Do you want to reset the screen and delete the saved images?" :
        "Do you want to fetch photos from the server and save them?"
    }
}

// MARK: - NoAnimationButtonStyle
fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
