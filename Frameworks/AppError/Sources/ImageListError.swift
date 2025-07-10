//
//  ImageListError.swift
//  AppError
//
//  Created by Taemin Yun on 2025-07-09.
//

public enum ImageListError: AppErrorMakable {
    
    case emptySource
    case outOfIndex
    case unknown
    
    public var message: String {
        switch self {
            case .emptySource:  return "There are no images left to add."
            case .outOfIndex:   return "No image available to remove."
            case .unknown:      return "An unknown error has occurred."
        }
    }
}
