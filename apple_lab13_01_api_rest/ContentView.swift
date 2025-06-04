//
//  ContentView.swift
//  apple_lab13_01_api_rest
//
//  Created by developer on 6/4/25.
//

import SwiftUI

// MARK: - Main Content View
struct ContentView: View {
    
    @StateObject private var apiService = PetsAPIService()
    
    var body: some View {
        NavigationView {
            VStack {
                if apiService.isLoading {
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Loading pets...")
                            .padding(.top)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = apiService.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("Error")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button("Retry") {
                            apiService.fetchPets()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if apiService.pets.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No pets found")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Pull to refresh or check your API connection")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(apiService.pets) { pet in
                        PetRowView(pet: pet)
                    }
                    .refreshable {
                        apiService.fetchPets()
                    }
                }
            }
            .navigationTitle("Pets")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        apiService.fetchPets()
                    }
                    .disabled(apiService.isLoading)
                }
            }
        }
        .onAppear {
            apiService.fetchPets()
        }
    }
}


#Preview {
    ContentView()
}
