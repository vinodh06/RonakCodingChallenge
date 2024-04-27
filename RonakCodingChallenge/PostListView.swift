//
//  PostListView.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import ComposableArchitecture
import SwiftUI

struct PostListView: View {

    @Bindable var store: StoreOf<PostListFeature>

    var body: some View {
        ZStack {

            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(store.posts) { post in
                            NavigationLink {
                                PostDetailView(post: post)
                            } label: {
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Id: \(post.id)")
                                            Text(post.title)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .foregroundColor(.black)
                                        .padding()
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.blue)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                }
                            }

                        }

                        // Detect when the user scrolls to the bottom
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                let isNearBottom = geometry.frame(in: .global).midY <= UIScreen.main.bounds.height
                                if isNearBottom && !store.isRequestInFlight &&
                                    !store.isLoadingMore {
                                    store.send(.loadPosts)
                                }
                            }
                        }
                        .frame(width: 0, height: 0)
                    }
                }

                Spacer()

                if store.isLoadingMore {
                    Text("Loading...")
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .frame(height: 30)
                }
            }

            if store.isRequestInFlight {
                LoaderView()
            }
        }
        .task {
            store.send(.loadPosts)
        }
    }

    struct LoaderView: View {
        var body: some View {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle()
                    )
                    .scaleEffect(1.5)
                    .tint(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    NavigationView {
        PostListView(store: Store(initialState: PostListFeature.State()) {
            PostListFeature()
        } withDependencies: {
            $0.postClient = .mockValue
        })
        .navigationTitle("Posts")
    }
}
