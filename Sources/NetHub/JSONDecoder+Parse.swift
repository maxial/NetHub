//
//  DataDecoder.swift
//  NetHub
//
//  Created by Maxim Aliev on 15.01.2023.
//

import Foundation

extension JSONDecoder {
    
    func parse<T: Decodable>(data: Data) throws -> T {
        do {
            return try decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
