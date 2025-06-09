//
//  PetServiceError.swift
//  apple_lab13_01_api_rest
//
//  Created by Jaime Gomez on 8/6/25.
//

import Foundation

enum PetServiceError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
}
