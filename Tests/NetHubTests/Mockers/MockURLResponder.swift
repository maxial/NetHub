//
//  MockURLResponder.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation

protocol MockURLResponder {
    
    static func respond(to request: URLRequest) throws -> Data
}
