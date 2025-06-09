//
//  PetService.swift
//  apple_lab13_01_api_rest
//
//  Created by Jaime Gomez on 8/6/25.
//

import Foundation

class PetService {
    
    private let session = URLSession.shared
//    private let baseURL = "http://localhost:8080"
    private let baseURL = "http://3.92.45.93:8080"
    
    var errorMessage: String?
    
    func fetchPets() async throws -> [Pet]{

        errorMessage = nil

        guard let url = URL(string: "\(baseURL)/pets") else {
            throw PetServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                throw PetServiceError.serverError(statusCode: statusCode)
            }
            
            let pets = try JSONDecoder().decode([Pet].self, from: data)
            return pets
            
        } catch let decodingError as DecodingError {
            throw PetServiceError.decodingError(decodingError)
        } catch {
            throw PetServiceError.networkError(error)
        }

    }

}
