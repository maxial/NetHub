//
//  XCTestCase+AwaitCompletion.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import XCTest
import Combine

extension XCTestCase {
    
    func awaitCompletion<P: Publisher>(
        of publisher: P,
        timeout: TimeInterval = 10
    ) throws -> [P.Output] {
        let expectation = self.expectation(description: "Awaiting publisher completion")
        
        var completion: Subscribers.Completion<P.Failure>?
        var output: [P.Output] = []
        
        let cancellable = publisher.sink {
            completion = $0
            expectation.fulfill()
        } receiveValue: {
            output.append($0)
        }
        
        waitForExpectations(timeout: timeout)

        switch completion {
        case .failure(let error):
            throw error
        case .finished:
            return output
        case nil:
            cancellable.cancel()
            return []
        }
    }
}
