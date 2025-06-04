//
//  PetRowView.swift
//  apple_lab13_01_api_rest
//
//  Created by developer on 6/4/25.
//

import SwiftUI

// MARK: - Pet Row View
struct PetRowView: View {
    let pet: Pet
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(pet.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(pet.typeName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Born: \(pet.formattedBirthDate)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("ID: \(pet.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Owner: \(pet.ownerId)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    // PetRowView()
}
