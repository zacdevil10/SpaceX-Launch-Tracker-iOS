//
//  NetworkError.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

enum NetworkError : Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension NetworkError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case.missingData:
            return NSLocalizedString("Found and will discard with missing data", comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching data over the network.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
