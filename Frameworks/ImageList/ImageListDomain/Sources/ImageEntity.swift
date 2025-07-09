//
//  ImageEntity.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-07.
//

import Foundation

public struct ImageEntity: Identifiable, Hashable {
    
    public let id: String
    public let url: String
    public let author: String
    
    public init(id: String, url: String, author: String) {
        self.id = id
        self.url = url
        self.author = author
    }
}
