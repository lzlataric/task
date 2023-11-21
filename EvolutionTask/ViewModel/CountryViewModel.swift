//
//  CountryViewModel.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import Foundation
import Combine

class CountryViewModel: ObservableObject {
    @Published var searchedCountry = ""
    @Published var fetchedCountries: [Country]? = nil
    @Published var order: OrderFilter = .ascending
    @Published var filterType: Filter = .alphabetic
    private var cancellables = Set<AnyCancellable>()
    
    private var repository = DataRepository()
    
    init() {
        $searchedCountry
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] enteredText in
                guard let self = self else { return }
                if enteredText == "" {
                    self.fetchedCountries = nil
                } else {
                    Task {
                        do {
                            let fetchedData = try await self.repository.getCountriesByName(countryName: enteredText)
                            await MainActor.run {
                                self.filterSort(type: self.filterType, collection:fetchedData)
                            }
                        } catch {
                            throw error
                        }
                    }
                }
            })
            .store(in: &cancellables)
        
        $filterType
            .dropFirst()
            .sink { [weak self] type in
                guard let self = self,
                      let fetchedCountries = fetchedCountries
                else { return }
                self.filterSort(type: type, collection: fetchedCountries)
            }
            .store(in: &cancellables)
        
        $order
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.fetchedCountries?.reverse()
            }
            .store(in: &cancellables)
    }
    
    func getCountryByCode(countryCodes: [String]) async throws -> [Country] {
        do {
            return try await self.repository.getCountriesByCode(countryCodes: countryCodes)
        } catch {
            throw error
        }
    }
    
    private func filterSort(type: Filter, collection: [Country]) {
        switch type {
        case .alphabetic:
            if order == .ascending {
                self.fetchedCountries = collection.sorted{ $0.name.common < $1.name.common }
            } else {
                self.fetchedCountries = collection.sorted{ $0.name.common > $1.name.common }
            }
        case .population:
            if order == .ascending {
                self.fetchedCountries = collection.sorted{ $0.population > $1.population }
            } else {
                self.fetchedCountries = collection.sorted{ $0.population < $1.population }
            }
        case .surface:
            if order == .ascending {
                self.fetchedCountries = collection.sorted{ $0.area > $1.area }
            } else {
                self.fetchedCountries = collection.sorted{ $0.area < $1.area }
            }
        }
    }
}
