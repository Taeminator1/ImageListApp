//
//  NetworkError.swift
//  AppError
//
//  Created by Taemin Yun on 2025-07-07.
//

public enum NetworkError: AppErrorMakable {
    
    case invalidURL
    case decodingFailed
    case requestFailed
    
    public var message: String {
        switch self {
            case .invalidURL:       return "The URL provided was invalid."
            case .decodingFailed:   return "Failed to decode the server response."
            case .requestFailed:    return "The network request failed. Please check your internet connection."
        }
    }
}
