import XCTest
@testable import NetHub

final class NetHubTests: XCTestCase {
    
    func testSuccessfullyPerformingPublisherRequest() throws {
        let urlSession = URLSession(mockResponder: MockProfileURLResponder.self)
        let publisher: PublisherResult<Profile> = urlSession.publisher(
            endpoint: MockAPIs.getProfile(
                name: MockProfileURLResponder.profile.name,
                age: MockProfileURLResponder.profile.age
            )
        )
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [MockProfileURLResponder.profileResult])
    }
    
    func testSuccessfullyPerformingGeneralRequest() throws {
        let urlSession = URLSession(mockResponder: MockProfileURLResponder.self)
        var profileResult: Result<Profile, NetworkError>?
        
        let exp = expectation(description: "General Request")
        
        urlSession.request(
            endpoint: MockAPIs.getProfile(
                name: MockProfileURLResponder.profile.name,
                age: MockProfileURLResponder.profile.age
            )
        ) { (result: Result<Profile, NetworkError>) in
            profileResult = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(profileResult, MockProfileURLResponder.profileResult)
    }
}
