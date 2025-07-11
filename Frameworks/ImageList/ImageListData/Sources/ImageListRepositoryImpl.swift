//
//  ImageListRepositoryImpl.swift
//  ImageListData
//
//  Created by Taemin Yun on 2025-07-07.
//

import Foundation
import RealmSwift

import AppError
import ImageListDomain

public struct ImageListRepositoryImpl: ImageListRepository {
    
    public init() { }
    
    public func savedImages() async throws -> ImageGroupEntity {
        if !cachedImages.isEmpty {
            return ImageGroupEntity(
                cachedImages: cachedImages,
                displayedImages: displayedImages
            )
        }

        guard let url = URL(string: "https://picsum.photos/v2/list") else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([ImageResponse].self, from: data)
        let entities = response.map { $0.entity }

        do {
            try await MainActor.run {
                let realm = try Realm()
                try realm.write {
                    for entity in entities {
                        let item = CachedImageItem(id: entity.id, url: entity.url, author: entity.author)
                        realm.add(item, update: .modified)
                    }
                }
            }
        } catch {
            print("Realm Error")
        }

        return ImageGroupEntity(
            cachedImages: entities,
            displayedImages: []
        )
    }
    
    public func saveImages(imageGroup: ImageGroupEntity) async {
        do {
            try await MainActor.run {
                let realm = try Realm()
                try realm.write {
                    realm.deleteAll()
                    
                    for image in imageGroup.cachedImageEntities {
                        let item = CachedImageItem(id: image.id, url: image.url, author: image.author)
                        realm.add(item)
                    }
                    
                    for image in imageGroup.displayedImageEntities {
                        let item = DisplayedImageItem(id: image.id, url: image.url, author: image.author)
                        realm.add(item)
                    }
                }
            }
        } catch {
            print("Realm Error")
        }
    }
}

private extension ImageListRepositoryImpl {
    var cachedImages: [ImageEntity] {
        guard let realm = try? Realm() else { return [] }
        let saved = realm.objects(CachedImageItem.self)
        return saved.map { ImageEntity(id: $0.id, url: $0.url, author: $0.author) }
    }
    
    var displayedImages: [ImageEntity] {
        guard let realm = try? Realm() else { return [] }
        let saved = realm.objects(DisplayedImageItem.self)
        return saved.map { ImageEntity(id: $0.id, url: $0.url, author: $0.author) }
    }
}
