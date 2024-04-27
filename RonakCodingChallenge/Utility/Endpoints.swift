//
//  Endpoints.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import Networking

extension URLBuilder {
    public static let baseURL = URLBuilder {
        URLComponent.scheme("https")
        URLComponent.host("jsonplaceholder.typicode.com")
    }

    public static let posts = baseURL.path("posts")
}
