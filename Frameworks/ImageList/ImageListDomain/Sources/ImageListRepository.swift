//
//  ImageListRepository.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-07.
//

public protocol ImageListRepository {
    func savedImages() async throws -> ImageGroupEntity
    func saveImages(imageGroup: ImageGroupEntity) async
}

