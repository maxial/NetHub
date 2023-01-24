//
//  HTTPResponse.swift
//  
//
//  Created by Maxim Aliev on 24.01.2023.
//

import Foundation

struct HTTPResponse {
    
    let response: HTTPURLResponse?
    let body: Data?
    
    init(request: URLRequest, statusCode: Int, body: Data? = nil) {
        if let url = request.url {
            self.response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )
        } else {
            self.response = nil
        }
        self.body = body
    }
}
