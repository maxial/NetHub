//
//  URLSession+InitMock.swift
//  
//
//  Created by Maxim Aliev on 16.01.2023.
//

import Foundation

extension URLSession {
    
    convenience init<T: MockURLResponder>(mockResponder: T.Type) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol<T>.self]
        self.init(configuration: config)
        URLProtocol.registerClass(MockURLProtocol<T>.self)
    }
}
