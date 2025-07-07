//
//  ImageResponse.swift
//  ImageListData
//
//  Created by Taemin Yun on 2025-07-07.
//

import ImageListDomain

struct ImageResponse: Codable {
    let id: String
    let url: String
    let author: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case author = "author"
    }
    
    var entity: ImageEntity {
        ImageEntity(
            id: id,
            imageURL: url,
            author: author
        )
    }
}

