//
//  ImageListUseCase.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-08.
//

import Foundation

public final actor ImageListUseCase {
    
    private var images: Set<ImageEntity> = []
    private let repository: ImageListRepository
    
    public init(repository: ImageListRepository) {
        self.repository = repository
    }
    
    public func fetch() async throws {
        images = Set(try await repository.fetchedImages())
    }
    
    public func popRandomImage() -> ImageEntity? {
        guard let randomImage = images.randomElement() else { return nil }
        images.remove(randomImage)
        return randomImage
    }
    
    public func updateImages(with image: ImageEntity) {
        images.update(with: image)
    }
}

