//
//  Enums.swift
//  EvolutionTask
//
//  Created by Luka on 21.11.2023..
//

import Foundation

enum Filter: String, CaseIterable {
    case alphabetic = "Alphabetic"
    case population = "Population"
    case surface = "Surface"
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum OrderFilter: String {
    case ascending = "ascending"
    case descending = "descending"
    
    mutating func toggle() {
        switch self {
        case .ascending:
            self = .descending
        case .descending:
            self = .ascending
        }
    }
}
