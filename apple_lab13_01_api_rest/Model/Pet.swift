//
//  Pet.swift
//  apple_lab13_01_api_rest
//
//  Created by developer on 6/4/25.
//

import Foundation
// MARK: - Pet Model
struct Pet: Identifiable, Codable {
    let id: Int
    let name: String
    let typeId: Int
    let ownerId: Int
    let birthDate: String
    
    // Computed property to get formatted birth date
    var formattedBirthDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: birthDate) {
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.string(from: date)
        }
        return birthDate
    }
    
    // Computed property to get pet type name
    var typeName: String {
        switch typeId {
        case 1: return "Cat"
        case 2: return "Dog"
        case 3: return "Lizard"
        case 4: return "Snake"
        case 5: return "Bird"
        case 6: return "Hamster"
        default: return "Unknown"
        }
    }
}
