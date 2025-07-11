//
//  ImageGroupEntity.swift
//  ImageListDomain
//
//  Created by Taemin Yun on 2025-07-11.
//

import Foundation

public struct ImageGroupEntity {
    
    public let cachedImageEntities: [ImageEntity]
    public let displayedImageEntities: [ImageEntity]
    
    public init(
        cachedImages: [ImageEntity],
        displayedImages: [ImageEntity]
    ) {
        self.cachedImageEntities = cachedImages
        self.displayedImageEntities = displayedImages
    }
}
