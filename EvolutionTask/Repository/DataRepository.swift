//
//  DataRepository.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import Foundation

class DataRepository {
    private enum Constants {
        static let baseURL = "https://restcountries.com/v3.1"
    }
    
    func getCountries(urlString: String) async throws -> [Country] {
        guard let url = URL(string: urlString) else {
            throw Errors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw Errors.invalidResponse
        }
    
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Country].self, from: data)
        }
        catch {
            throw Errors.invalidData
        }
    }
    
    func getCountriesByName(countryName: String) async throws -> [Country] {
        let urlString = "\(Constants.baseURL)/name/\(countryName)"
        return try await getCountries(urlString: urlString)
    }
    
    func getCountriesByCode(countryCodes: [String]) async throws -> [Country] {
        let urlString = "\(Constants.baseURL)/alpha?codes=\(countryCodes.joined(separator: ","))"
        return try await getCountries(urlString: urlString)
    }

}
