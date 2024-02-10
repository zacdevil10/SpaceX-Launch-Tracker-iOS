//
//  HTTPDataDownloader.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/08/2023.
//

import Foundation

protocol HTTPDataDownloader {
    func get<T: Decodable>(url: String, model: T.Type, handler: @escaping (ApiResult<T>) -> Void)
}

extension URLSession: HTTPDataDownloader {
    
    func get<T: Decodable>(url: String, model: T.Type, handler: @escaping (ApiResult<T>) -> Void) {
        var decoder: JSONDecoder = {
            let aDecoder = JSONDecoder()
            aDecoder.dateDecodingStrategy = .millisecondsSince1970
            return aDecoder
        }()
        
        guard let url = URL(string: url) else {
            handler(.pending)
            return
        }
        let request = URLRequest(url: url)

        dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let response = try decoder.decode(model, from: data)
                    
                    DispatchQueue.main.async {
                        handler(.success(response))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        handler(.error(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if let error = error {
                        handler(.error(error))
                    }
                }
            }
        }.resume()
    }
}
