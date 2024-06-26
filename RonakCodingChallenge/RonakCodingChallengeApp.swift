//
//  RonakCodingChallengeApp.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct RonakCodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PostListView(store: Store(initialState: PostListFeature.State()) {
                    PostListFeature()
                        ._printChanges()
                })
                .navigationTitle("Posts")
            }
        }
    }
}
