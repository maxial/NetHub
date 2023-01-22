//
//  URLSession+Request.swift
//  
//
//  Created by Maxim Aliev on 15.01.2023.
//

import Foundation

extension URLSession {
    
    public func request<T: Decodable>(
        endpoint: API,
        decoder: JSONDecoder = .init(),
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        do {
            let urlRequest = try endpoint.asURLRequest()
            
            let task = dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return completion(.failure(error.asNetworkError))
                }
                
                guard let data = data else {
                    return completion(.failure(.noData))
                }
                
                guard let response = response else {
                    return completion(.failure(.invalidResponse))
                }
                
                do {
                    let data = try self.handleResponse(data: data, response: response)
                    let model: T = try decoder.parse(data: data)
                    return completion(.success(model))
                } catch {
                    return completion(.failure(error.asNetworkError))
                }
            }
            
            task.resume()
        } catch {
            return completion(.failure(error.asNetworkError))
        }
    }
}
