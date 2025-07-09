//
//  ImageListViewModel.swift
//  ImageListPresentation
//
//  Created by Taemin Yun on 2025-07-08.
//

import Foundation
import ImageListDomain

@MainActor
final class ImageListViewModel: ObservableObject {
    @Published private(set) var images: [ImageEntity] = []
    
    private let useCase: ImageListUseCase
    
    init(repository: ImageListRepository) {
        self.useCase = ImageListUseCase(repository: repository)
    }
    
    func fetch() async throws {
        try await useCase.fetch()
    }
    
    func add() async throws {
        images = try await useCase.addedRandomImage()
    }
    
    func removeImage(atOffsets offsets: IndexSet) async throws {
        images = try await useCase.updatedImages(atOffsets: offsets)
    }
    
    func moveImage(fromOffsets source: IndexSet, toOffset destination: Int) async throws {
        images.move(fromOffsets: source, toOffset: destination)
        try await useCase.updateDisplayedImages(with: images)
    }
}
