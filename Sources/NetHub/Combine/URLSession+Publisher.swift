//
//  URLSession+Publisher.swift
//  NetHub
//
//  Created by Maxim Aliev on 10.01.2023.
//

import Foundation
import Combine

extension URLSession {
    
    public typealias PublisherResult<T> = AnyPublisher<Result<T, NetworkError>, Never>
    
    public func publisher<T: Decodable>(endpoint: API, decoder: JSONDecoder = .init()) -> PublisherResult<T> {
        catchError {
            let urlRequest = try endpoint.asURLRequest()
            return dataTaskPublisher(for: urlRequest)
                .mapError { $0.asNetworkError }
                .tryMap(handleResponse)
                .tryMap(decoder.parse)
                .mapError { $0.asNetworkError }
                .eraseToAnyPublisher()
        }
        .asResult()
    }
    
    private func catchError<T>(
        _ request: () throws -> AnyPublisher<T, NetworkError>
    ) -> AnyPublisher<T, NetworkError> {
        do {
            return try request()
        } catch {
            return Fail(error: error.asNetworkError).eraseToAnyPublisher()
        }
    }
}
