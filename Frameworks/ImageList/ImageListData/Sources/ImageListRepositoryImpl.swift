//
//  ImageListRepositoryImpl.swift
//  ImageListData
//
//  Created by Taemin Yun on 2025-07-07.
//

import Foundation

import AppError
import ImageListDomain

public struct ImageListRepositoryImpl: ImageListRepository {
    
    public init() { }
    
    public func fetchedImages() async throws -> [ImageEntity] {
        guard let url = URL(string: "https://picsum.photos/v2/list") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let data = try await URLSession.shared.data(from: url).0
            guard let response = try? JSONDecoder().decode(Array<ImageResponse>.self, from: data) else {
                throw NetworkError.decodingFailed
            }
            return response.map { $0.entity }
        } catch {
            throw NetworkError.requestFailed
        }
    }
}

