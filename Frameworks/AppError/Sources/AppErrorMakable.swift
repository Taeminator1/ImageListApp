//
//  AppErrorMakable.swift
//  AppError
//
//  Created by Taemin Yun on 2025-07-10.
//

public protocol AppErrorMakable: Error {
    var message: String { get }
}
