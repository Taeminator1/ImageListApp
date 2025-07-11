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
    @Published private(set) var cachedImagesLoaded: Bool = false
    
    private let useCase: ImageListUseCase
    
    init(repository: ImageListRepository) {
        self.useCase = ImageListUseCase(repository: repository)
    }
    
    func fetch() async throws {
        do {
            images = try await useCase.fetch()
            cachedImagesLoaded = true
        } catch let error {
            cachedImagesLoaded = false
            throw error
        }
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
    
    func reset() async {
        images = await useCase.reset()
        cachedImagesLoaded = false
    }
}
