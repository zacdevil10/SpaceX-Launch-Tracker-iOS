//
//  ApiResult.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 11/08/2023.
//

import Foundation

enum ApiResult<R> {
    case success(R)
    case pending
    case error(Error)

    func transform<T>(transform: (R) -> T) -> ApiResult<T> {
        switch self {
        case .pending:
            return .pending
        case .success(let data):
            return .success(transform(data))
        case .error(let error):
            return .error(error)
        }
    }
}
