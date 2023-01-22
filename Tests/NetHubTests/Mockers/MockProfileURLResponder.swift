//
//  File.swift
//  
//
//  Created by Maxim Aliev on 23.01.2023.
//

import Foundation
@testable import NetHub

enum MockProfileURLResponder: MockURLResponder {
    
    static let profile = Profile(name: "Maxim", age: 28)
    static let profileResult: Result<Profile, NetworkError> = .success(profile)
    
    static func respond(to request: URLRequest) throws -> Data {
        return try JSONEncoder().encode(profile)
    }
}
