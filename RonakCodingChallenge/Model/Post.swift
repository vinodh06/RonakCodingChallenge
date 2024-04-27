//
//  Post.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import Foundation

struct Post: Codable, Equatable, Identifiable {
    let userId, id: Int
    let title, body: String
}
