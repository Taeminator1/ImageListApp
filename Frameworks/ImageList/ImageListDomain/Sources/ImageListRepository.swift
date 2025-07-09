//
//  ImageListRepository.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-07.
//

public protocol ImageListRepository {
    func fetchedImages() async throws -> [ImageEntity]
}

