//
//  DataRepository.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import Foundation

class DataRepository {

    func getCountriesByName(countryName: String) async throws -> [Country] {
        let endPoint = "https://restcountries.com/v3.1/name/\(countryName)"
        guard let url = URL(string: endPoint) else {
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
    
    func getCountriesByCode(countryCodes: [String]) async throws -> [Country] {
        let endPoint = "https://restcountries.com/v3.1/alpha?codes=\(countryCodes.joined(separator: ","))"
        guard let url = URL(string: endPoint) else {
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

}
