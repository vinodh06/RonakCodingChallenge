//
//  PostClient.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import ComposableArchitecture
import Foundation
import Networking

@DependencyClient
struct PostClient {
    var posts: () async throws -> [Post]
}

extension PostClient: DependencyKey {
    static var liveValue = Self {
        return try await NetworkService.request(for: .posts)
    }

    static var testValue: PostClient = Self()

    static var mockValue = Self {
        guard let posts: [Post] = DataLoader.load("mock_post_response.json") else {
            return []
        }
        return posts
    }

}

extension DependencyValues {
    var postClient: PostClient {
        get { self[PostClient.self] }
        set { self[PostClient.self] = newValue }
    }
}
