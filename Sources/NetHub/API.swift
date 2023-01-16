//
//  API.swift
//  InterviewPreparation
//
//  Created by Maxim Aliev on 07.01.2023.
//

import Foundation

public enum HTTPMethod: String {
    
    case GET
    case POST
    case PUT
    case DELETE
}

public enum HTTPScheme: String {
    
    case http
    case https
}

public protocol API {
    
    var method: HTTPMethod { get }
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
    func asURL() throws -> URL
    func asURLRequest() throws -> URLRequest
}

extension API {
    
    func asURL() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = parameters
        guard let url = components.url else {
            throw NetworkError.invalidURL(baseURL + path)
        }
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        for (key, value) in headers ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
