//
//  DataLoader.swift
//  RonakCodingChallenge
//
//  Created by vinodh kumar on 27/04/24.
//

import Foundation

struct DataLoader {
    static func load<T: Decodable>(
        _ filename: String,
        decoder: JSONDecoder = JSONDecoder()
    ) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let loadedData = try decoder.decode(T.self, from: data)
            return loadedData
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
