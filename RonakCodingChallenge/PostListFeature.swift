//
//  PostListFeature.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import ComposableArchitecture

@Reducer
struct PostListFeature {
    @ObservableState
    struct State: Equatable {
        var isRequestInFlight = false
        var isLoadingMore = false
        var pageNo: Int = 0
        var posts: [Post] = []
        var allPosts: [Post] = []
    }

    enum Action {
        case loadPosts
        case loadPostsResponse(Result<[Post], Error>)
        case addPosts([Post])
    }

    @Dependency(\.postClient.posts) var postClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .addPosts(posts):
                state.isLoadingMore = false
                state.pageNo += 1
                state.posts += posts
                return .none

            case .loadPosts:
                guard !state.isRequestInFlight, state.pageNo < 5 else { return .none }
                if state.pageNo == 0 {
                    state.isRequestInFlight = true
                    return .run { send in
                        await send(.loadPostsResponse(Result {
                            try await postClient()
                        }))
                    }
                } else {
                    state.isLoadingMore = true
                    return .run { [pageNo = state.pageNo, allPosts = state.allPosts] send in
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        let startIndex = pageNo * 10
                        let endIndex = startIndex + 10
                        let posts = Array(allPosts[startIndex..<endIndex])
                        await send(.addPosts(posts))
                    }
                }

            case let .loadPostsResponse(.success(posts)):
                state.isRequestInFlight = false
                state.allPosts = posts
                state.pageNo += 1
                state.posts = posts[..<10].map { $0 }
                return .none

            case let .loadPostsResponse(.failure(error)):
                print("Error: ", error)
                state.isRequestInFlight = false
                return .none
            }
        }
    }
}
