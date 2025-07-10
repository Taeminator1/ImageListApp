//
//  ImageListUseCase.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-08.
//

import Foundation

import AppError

public final actor ImageListUseCase {
    
    private var cachedImages: [ImageEntity] = []
    private var displayedImages: [ImageEntity] = []
    private let repository: ImageListRepository
    
    public init(repository: ImageListRepository) {
        self.repository = repository
    }
    
    public func fetch() async throws {
        do {
            cachedImages = try await repository.fetchedImages()
        } catch let error {
            reset()
            throw error
        }
    }
    
    public func addedRandomImage() throws -> [ImageEntity] {
        guard let randomImage = cachedImages.randomElement(),
              let randomImageIndex = cachedImages.firstIndex(of: randomImage) else {
            throw ImageListError.emptySource
        }
        
        cachedImages.remove(at: randomImageIndex)
        displayedImages.append(randomImage)
        
        return displayedImages
    }
    
    public func updatedImages(atOffsets offsets: IndexSet) throws -> [ImageEntity] {
        guard let index = offsets.first,
              displayedImages.indices ~= index else {
            throw ImageListError.outOfIndex
        }
        
        cachedImages.append(displayedImages.remove(at: index))
        return displayedImages
    }
    
    public func updateDisplayedImages(with images: [ImageEntity]) throws {
        guard Set(images) == Set(displayedImages) else {
            throw ImageListError.unknown
        }
        
        displayedImages = images
    }
    
    @discardableResult
    public func reset() -> [ImageEntity] {
        cachedImages = []
        displayedImages = []
        return displayedImages
    }
}

