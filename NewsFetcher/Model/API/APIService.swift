//
//  APIService.swift
//  NewsFetcher
//
//  Created by Caleb Wolfe on 10/27/25.
//

import Foundation

public struct APIService {
    private let apiKey: String? = {
        guard let path = Bundle.main.url(forResource: "Secrets",
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: path) else {
            print("Error: Could not find Secrets.plist or read data.")
            return nil
        }

        do {
            let decoder = PropertyListDecoder()
            let secrets = try decoder.decode(Secrets.self, from: data)
            return secrets.NewsApiKey
        } catch {
            print("Error decoding plist: \(error)")
            return nil
        }
    }()
    
}

struct Secrets: Decodable {
    let NewsApiKey: String
}

enum APIError: Error {
    case invalidURL
    case badServerResponse
    case decodingError
    case plistDecodingError
}
