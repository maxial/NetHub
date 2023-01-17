//
//  Profile.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation
@testable import NetHub

struct Profile: Codable, Equatable {
    
    var name: String
    var age: Int
}

extension Profile {
    
    enum MockDataURLResponder: MockURLResponder {
        
        static let profile = Profile(name: "Maxim", age: 28)
        static let profileResult: Result<Profile, NetworkError> = .success(profile)
        
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(profile)
        }
    }
}
