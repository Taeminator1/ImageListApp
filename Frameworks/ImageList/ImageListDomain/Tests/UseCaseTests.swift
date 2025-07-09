
//  UseCaseTests.swift
//  ImageListDomainTests
//
//  Created by Taemin Yun on 2025-07-08.
//

import Testing
@testable import ImageListDomain


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
        "Check the number of images when poping images",
        arguments: [0, 2]
    )
    func imageCount(numberOfImagesToAdd: UInt) async throws {
        
        for i in 0..<numberOfImagesToAdd {
            await sut.updateImages(
                with: ImageEntity(id: "\(i)", url: "https://a.com", author: "duck")
            )
        }

        var imageCount = 0
        while await sut.popRandomImage() != nil {
            imageCount += 1
        }
        
        #expect(imageCount == numberOfImagesToAdd + UInt(mockImages.count))
    }
    
    @Test("Validate set of images")
    func randomImages() async throws {
        
        var addedImages: Set<ImageEntity> = []
        while let image = await sut.popRandomImage() {
            addedImages.update(with: image)
        }
        
        #expect(Set(mockImages) == addedImages)
    }

}

private struct MockImageListRepository: ImageListRepository {
    let images: [ImageEntity]
    
    func fetchedImages() async throws -> [ImageEntity] {
        return images
    }
}
