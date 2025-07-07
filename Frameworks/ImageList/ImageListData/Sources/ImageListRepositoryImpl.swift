//
//  ImageListRepositoryImpl.swift
//  ImageListData
//
//  Created by Taemin Yun on 2025-07-07.
//

import Foundation
import ImageListDomain

public struct ImageListRepositoryImpl: ImageListRepository {
    
    public init() { }
    
    public func fetchImages() async throws -> [ImageListDomain.ImageEntity] {
        guard let url = URL(string: "https://picsum.photos/v2/list") else {
            throw NetworkError.unknown
        }
        
        do {
            let data = try await URLSession.shared.data(from: url).0
            guard let response = try? JSONDecoder().decode(Array<ImageResponse>.self, from: data) else {
                throw NetworkError.unknown
            }
            return response.map { $0.entity }
        } catch {
            throw NetworkError.unknown
        }
    }
}

