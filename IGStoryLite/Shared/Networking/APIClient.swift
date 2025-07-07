//
//  APIClient.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(_ url: URL) async throws -> T
}
