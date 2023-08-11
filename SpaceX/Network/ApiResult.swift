//
//  ApiResult.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case pending
    case error(Error)
}
