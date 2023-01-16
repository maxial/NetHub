//
//  Publisher+AsResult.swift
//  Sandbox
//
//  Created by Maxim Aliev on 15.01.2023.
//

import Combine

extension Publisher {
    
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        return self
            .map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}
