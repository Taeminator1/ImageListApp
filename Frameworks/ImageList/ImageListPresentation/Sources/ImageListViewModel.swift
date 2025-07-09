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
        await useCase.popRandomImage().map {
            images.append($0)
        }
    }
    
    func remove(atOffsets offsets: IndexSet) async throws {
        guard let index = offsets.first,
              images.indices ~= index else { return }
        
        let imageToUpdate = images[index]
        images.remove(atOffsets: offsets)
        await useCase.updateImages(with: imageToUpdate)
    }
}
