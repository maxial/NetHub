//
//  URLSession+HandleResponse.swift
//  Sandbox
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation

extension URLSession {
    
    private enum Constants {
        
        static let acceptableStatusCodes: Range<Int> = 200..<300
    }
    
    func handleResponse(data: Data, response: URLResponse) throws -> Data {
        if let httpResponse = response as? HTTPURLResponse {
            if Constants.acceptableStatusCodes ~= httpResponse.statusCode {
                return data
            } else {
                throw NetworkError.by(httpStatusCode: httpResponse.statusCode)
            }
        } else {
            throw NetworkError.invalidResponse
        }
    }
}
