//
//  MockURLResponder.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation
@testable import NetHub

protocol MockURLResponder {
    
    static func respond(to request: URLRequest) throws -> HTTPResponse
}

protocol MockErrorURLResponder: MockURLResponder {
    
    static var error: NetworkError { get }
}

enum MockProfileURLResponder: MockURLResponder {
    
    private static let profile = Profile(name: "Maxim", age: 28)
    
    static let profileResult: Result<Profile, NetworkError> = .success(profile)
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(
            request: request,
            statusCode: 200,
            body: try JSONEncoder().encode(profile)
        )
    }
}

enum MockBadRequestURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .badRequest
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 400)
    }
}

enum MockUnauthorizedURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .unauthorised
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 401)
    }
}

enum MockForbiddenURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .forbidden
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 403)
    }
}

enum MockNotFoundURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .notFound
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 404)
    }
}

enum MockNotAcceptableURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .notAcceptable
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 406)
    }
}

enum MockConflictURLResponder: MockErrorURLResponder {
    
    static let error: NetworkError = .conflict
    
    static func respond(to request: URLRequest) throws -> HTTPResponse {
        return HTTPResponse(request: request, statusCode: 409)
    }
}
