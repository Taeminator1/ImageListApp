//
//  ImageEntity.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-07.
//

import Foundation

public struct ImageEntity: Identifiable {
    
    public let id: String
    public let imageURL: String
    public let author: String
    
    public init(id: String, imageURL: String, author: String) {
        self.id = id
        self.imageURL = imageURL
        self.author = author
    }
}
