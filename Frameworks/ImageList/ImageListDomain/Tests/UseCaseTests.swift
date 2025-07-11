
//  UseCaseTests.swift
//  ImageListDomainTests
//
//  Created by Taemin Yun on 2025-07-08.
//

import Testing
import Foundation

@testable import ImageListDomain
@testable import AppError


struct UseCaseTests {
    
    private let sut: ImageListUseCase
    
    private let mockImages = [
        ImageEntity(id: "123", url: "https://x.com", author: "apple"),
        ImageEntity(id: "456", url: "https://y.com", author: "book"),
        ImageEntity(id: "789", url: "https://z.com", author: "cat")
    ]
    
    init() async throws {
        sut = ImageListUseCase(repository: MockImageListRepository(images: mockImages))
        try await sut.fetch()
    }
    
    @Test(
        "Check image count when adding images and error on overflow"
    )
    func imageCount() async throws {
        var displayedImages: [ImageEntity] = []

        for i in 0..<mockImages.count {
            displayedImages = try await sut.addedRandomImage()
            #expect(displayedImages.count == i+1)
        }

        await #expect(
            throws: ImageListError.emptySource,
            performing: {
                _ = try await sut.addedRandomImage()
            }
        )
    }
    
    @Test("Validate set of images")
    func randomImages() async throws {
        
        var displayedImages: [ImageEntity] = []
        for _ in 0 ..< mockImages.count {
            displayedImages = try await sut.addedRandomImage()
        }
        
        #expect(Set(mockImages) == Set(displayedImages))
    }
    
    @Test(
        "Remove all displayed images and error on out of index"
    )
    func updatedImages() async throws {
        
        var displayedImages: [ImageEntity] = []
        
        for _ in 0..<mockImages.count {
            displayedImages = try await sut.addedRandomImage()
        }
        #expect(Set(displayedImages) == Set(mockImages))
        
        for _ in 0..<displayedImages.count {
            displayedImages = try await sut.updatedImages(atOffsets: IndexSet(integer: 0))
        }
        #expect(displayedImages.isEmpty)
        
        await #expect(
            throws: ImageListError.outOfIndex,
            performing: {
                _ = try await sut.updatedImages(atOffsets: IndexSet(integer: 0))
            }
        )
    }
    
    @Test(
        "Reorder displayed images"
    )
    func reordredImages() async throws {
        
        var displayedImages: [ImageEntity] = []
        for _ in 0..<mockImages.count {
            displayedImages = try await sut.addedRandomImage()
        }
        
        let reorderedImages = displayedImages.shuffled()
        try await sut.updateDisplayedImages(with: reorderedImages)
        displayedImages = try await getDisplayedImages(sut, from: reorderedImages)
        
        #expect(reorderedImages == displayedImages)
    }
    
    @Test(
        "Reset images"
    )
    func restoredImages() async {
        let displayedImages = await sut.reset()
        #expect(displayedImages.isEmpty)
    }
}

private extension UseCaseTests {
    func getDisplayedImages(_ sut: ImageListUseCase, from images: [ImageEntity]) async throws -> [ImageEntity] {
        guard let lastImage = images.last else { return [] }
        
        var displayedImages = try await sut.updatedImages(atOffsets: IndexSet(integer: images.count-1))
        displayedImages.append(lastImage)

        return displayedImages
    }
}

private struct MockImageListRepository: ImageListRepository {
    
    let images: [ImageEntity]
    
    func savedImages() async throws -> ImageGroupEntity {
        return ImageGroupEntity(
            cachedImages: images,
            displayedImages: []
        )
    }
    
    func saveImages(imageGroup: ImageListDomain.ImageGroupEntity) async { }
}
