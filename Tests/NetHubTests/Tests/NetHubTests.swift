import XCTest
@testable import NetHub

final class NetHubTests: XCTestCase {
    
    func testSuccessCombineGETRequest() throws {
        let urlSession = URLSession(mockResponder: MockProfileURLResponder.self)
        let publisher: PublisherResult<Profile> = urlSession.publisher(
            endpoint: MockAPIs.stub
        )
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [MockProfileURLResponder.profileResult])
    }
    
    func testSuccessGeneralGETRequest() throws {
        let urlSession = URLSession(mockResponder: MockProfileURLResponder.self)
        var profileResult: Result<Profile, NetworkError>?
        
        let exp = expectation(description: "General Request: Success")
        
        urlSession.request(
            endpoint: MockAPIs.stub
        ) { (result: Result<Profile, NetworkError>) in
            profileResult = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(profileResult, MockProfileURLResponder.profileResult)
    }
    
    func testBadRequestCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockBadRequestURLResponder.self)
    }
    
    func testUnauthorizedCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockUnauthorizedURLResponder.self)
    }
    
    func testForbiddenCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockForbiddenURLResponder.self)
    }
    
    func testNotFoundCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockNotFoundURLResponder.self)
    }
    
    func testNotAcceptableCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockNotAcceptableURLResponder.self)
    }
    
    func testConflictCombineGETRequest() throws {
        try testErrorCombineGETRequest(mock: MockConflictURLResponder.self)
    }
    
    func testBadRequestGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockBadRequestURLResponder.self)
    }
    
    func testUnauthorizedGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockUnauthorizedURLResponder.self)
    }
    
    func testForbiddenGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockForbiddenURLResponder.self)
    }
    
    func testNotFoundGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockNotFoundURLResponder.self)
    }
    
    func testNotAcceptableGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockNotAcceptableURLResponder.self)
    }
    
    func testConflictGeneralGETRequest() throws {
        try testErrorGeneralGETRequest(mock: MockConflictURLResponder.self)
    }
    
    func testErrorCombineGETRequest<T: MockErrorURLResponder>(mock: T.Type = T.self) throws {
        let urlSession = URLSession(mockResponder: T.self)
        let publisher: PublisherResult<Profile> = urlSession.publisher(
            endpoint: MockAPIs.stub
        )
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [.failure(T.error)])
    }
    
    private func testErrorGeneralGETRequest<T: MockErrorURLResponder>(mock: T.Type = T.self) throws {
        let urlSession = URLSession(mockResponder: T.self)
        var errorResult: Result<Profile, NetworkError>?
        
        let exp = expectation(description: T.error.errorDescription ?? "Error request")
        
        urlSession.request(
            endpoint: MockAPIs.stub
        ) { (result: Result<Profile, NetworkError>) in
            errorResult = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(errorResult, .failure(T.error))
    }
}
