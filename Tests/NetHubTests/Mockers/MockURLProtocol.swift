//
//  MockURLProtocol.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import XCTest
@testable import NetHub

final class MockURLProtocol<Responder: MockURLResponder>: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let client = client else { return }
        
        do {
            let httpResponse = try Responder.respond(to: request)
            
            if let response = httpResponse.response {
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            } else {
                throw NetworkError.invalidResponse
            }
            
            if let data = httpResponse.body {
                client.urlProtocol(self, didLoad: data)
            }
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }
        
        client.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
