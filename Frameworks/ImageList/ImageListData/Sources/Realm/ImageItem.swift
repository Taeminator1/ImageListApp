//
//  ImageItem.swift
//  ImageListData
//
//  Created by Taemin Yun on 2025-07-11.
//

import RealmSwift

public final class CachedImageItem: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var url: String
    @Persisted public var author: String

    public convenience init(id: String, url: String, author: String) {
        self.init()
        self.id = id
        self.url = url
        self.author = author
    }
}

public final class DisplayedImageItem: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var url: String
    @Persisted public var author: String

    public convenience init(id: String, url: String, author: String) {
        self.init()
        self.id = id
        self.url = url
        self.author = author
    }
}
