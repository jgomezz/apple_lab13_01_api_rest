//
//  PetsAPIService.swift
//  apple_lab13_01_api_rest
//
//  Created by developer on 6/4/25.
//

import SwiftUI

// MARK: - API Service
class PetViewModel: ObservableObject {

    @Published var pets: [Pet] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = PetService()

    func loadPets() async {
         isLoading = true
         errorMessage = nil
         
         do {
             pets = try await service.fetchPets()
         } catch PetServiceError.invalidURL {
             errorMessage = "Invalid URL"
         } catch PetServiceError.serverError(let statusCode) {
             errorMessage = "Server error: \(statusCode)"
         } catch PetServiceError.decodingError(let error) {
             errorMessage = "Data parsing error: \(error.localizedDescription)"
         } catch PetServiceError.networkError(let error) {
             errorMessage = "Network error: \(error.localizedDescription)"
         } catch {
             errorMessage = "Unknown error: \(error.localizedDescription)"
         }
         
         isLoading = false
     }
     
     // If you need a non-async version for button actions, etc.
     func loadPetsTask() {
         Task {
             await loadPets()
         }
     }
}
