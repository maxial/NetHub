import XCTest
@testable import NetHub

final class NetHubTests: XCTestCase {
    
    func testSuccessfullyPerformingRequest() throws {
        let urlSession = URLSession(mockResponder: Profile.MockDataURLResponder.self)
        let publisher: PublisherResult<Profile> = urlSession.publisher(
            endpoint: ProfileAPI.getProfile(
                name: Profile.MockDataURLResponder.profile.name,
                age: Profile.MockDataURLResponder.profile.age
            )
        )
        let result = try awaitCompletion(of: publisher)
        XCTAssertEqual(result, [Profile.MockDataURLResponder.profileResult])
    }
//    
//    func testSuccessfullyPerformingGeneralRequest() throws {
//        let urlSession = URLSession(mockResponder: Profile.MockDataURLResponder.self)
//        let publisher: PublisherResult<Profile> = urlSession.publisher(
//            endpoint: ProfileAPI.getProfile(
//                name: Profile.MockDataURLResponder.profile.name,
//                age: Profile.MockDataURLResponder.profile.age
//            )
//        )
//
//        urlSession.request(endpoint: ProfileAPI.getProfile(
//            name: Profile.MockDataURLResponder.profile.name,
//            age: Profile.MockDataURLResponder.profile.age
//        )) { <#Result<Decodable, NetworkError>#> in
//            <#code#>
//        }
//        let result = try awaitCompletion(of: publisher)
//        XCTAssertEqual(result, [Profile.MockDataURLResponder.profileResult])
//    }
}
