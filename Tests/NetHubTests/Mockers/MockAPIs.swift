//
//  MockAPIs.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation
@testable import NetHub

enum MockAPIs: API {
    
    case stub
    case getProfile(name: String, age: Int)
    
    var method: HTTPMethod {
        switch self {
        case .stub, .getProfile:
            return .GET
        }
    }
    
    var scheme: HTTPScheme {
        switch self {
        case .stub, .getProfile:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .stub, .getProfile:
            return "httpbin.org"
        }
    }
    
    var path: String {
        switch self {
        case .stub, .getProfile:
            return "/get"
        }
    }
    
    var parameters: [URLQueryItem] {
        var params: [URLQueryItem] = []
        switch self {
        case .stub:
            break
        case let .getProfile(name, age):
            params.append(URLQueryItem(name: "name", value: name))
            params.append(URLQueryItem(name: "age", value: "\(age)"))
        }
        return params
    }
    
    var headers: [String: String]? {
        switch self {
        case .stub, .getProfile:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        return nil
    }
}
