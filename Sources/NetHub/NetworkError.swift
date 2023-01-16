//
//  NetworkError.swift
//  NetHub
//
//  Created by Maxim Aliev on 10.01.2023.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidURL(String)
    case transportError(URLError)
    case noData
    case invalidResponse
    
    // 4xx
    case badRequest
    case unauthorised
    case forbidden
    case notFound
    case notAcceptable
    case conflict
    // 5xx
    case serverError(statusCode: Int)
    
    case decodingError(Error)
    case unknown(Error)
    
    static func by(httpStatusCode: Int) -> NetworkError {
        switch httpStatusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorised
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 406:
            return .notAcceptable
        case 409:
            return .conflict
        case 500...599:
            return .serverError(statusCode: httpStatusCode)
        default:
            return .unknown(NSError(domain: "com.maxial.sandbox", code: httpStatusCode))
        }
    }
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString):
            return "URL creation error. API path \(urlString)."
        case .transportError(let error):
            return "Please check your internet connection. Transport error: \(error)."
        case .noData:
            return "No Data"
        case .invalidResponse:
            return "Received an invalid response, non-HTTP result."
            
        case .badRequest:
            return "Bad Request 400."
        case .unauthorised:
            return "Unauthorized Request 401."
        case .forbidden:
            return "Forbidden 403."
        case .notFound:
            return "Not Found 404."
        case .notAcceptable:
            return "Not Acceptable Response 406."
        case .conflict:
            return "Conflict 409."
        case .serverError(let statusCode):
            return "Server error \(statusCode)."
            
        case .decodingError(let error):
            return "Decoding error: \(error)."
        case .unknown(let error):
            return "Unknown error: \(error)."
        }
    }
}

extension Error {
    
    var asNetworkError: NetworkError {
        if let networkError = self as? NetworkError {
            return networkError
        } else if let urlError = self as? URLError {
            return .transportError(urlError)
        } else {
            return .unknown(self)
        }
    }
}
