//
//  PostDetailView.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(post.title)")
                .font(.largeTitle)
            Text("\(post.body)")
                .font(.body)
            HStack {
                Text("Id: \(post.id)")
                Spacer()
                Text("User Id: \(post.userId)")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
    }
}
