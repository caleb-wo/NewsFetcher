//
//  APIService.swift
//  NewsFetcher
//
//  Created by Caleb Wolfe on 10/27/25.
//

import Foundation

public struct APIService {
    private let baseUrl = "https://newsdata.io/api/1/"
    private func getAPIKey() throws -> String? {
        guard let path = Bundle.main.url(forResource: "Secrets",
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: path) else {
            throw APIError.plistDecodingError
        }

        do {
            let decoder = PropertyListDecoder()
            let secrets = try decoder.decode(Secrets.self, from: data)
            return secrets.NewsApiKey
        } catch {
            throw APIError.plistDecodingError
        }
    }
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
