//
//  PetsAPIService.swift
//  apple_lab13_01_api_rest
//
//  Created by developer on 6/4/25.
//

import SwiftUI

// MARK: - API Service
class PetsAPIService: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let baseURL = "http://localhost:8080"
    
    func fetchPets() {
        guard let url = URL(string: "\(baseURL)/pets") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    self?.errorMessage = "Server error"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let pets = try JSONDecoder().decode([Pet].self, from: data)
                    self?.pets = pets
                } catch {
                    self?.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
