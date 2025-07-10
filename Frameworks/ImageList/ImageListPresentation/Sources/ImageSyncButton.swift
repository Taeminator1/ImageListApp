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
                    Task {
                        guard !isProcessing else { return }
                        await MainActor.run { isProcessing = true }
                        await onSync()
                        await MainActor.run { isProcessing = false }
                    }
                }) {
                    let imageName = cachedImagesLoaded ? "trash.circle.fill" : "arrow.down.circle"
                    Image(systemName: imageName)
                        .font(.system(size: 48))
                        .foregroundStyle(isProcessing ? .gray : .blue)
                        .padding()
                }
                .disabled(isProcessing)
                .buttonStyle(NoAnimationButtonStyle())
                .padding(.bottom, -24)
            }
        }
    }
}

// MARK: - NoAnimationButtonStyle
fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
