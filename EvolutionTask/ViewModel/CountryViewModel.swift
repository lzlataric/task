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
        subsribeToSearchPublisher()
        subsribeToFilterTypePublisher()
        subscribeToOrderPublisher()
    }
    
    func getCountryByCode(countryCodes: [String]) async throws -> [Country] {
        do {
            return try await self.repository.getCountriesByCode(countryCodes: countryCodes)
        } catch {
            throw error
        }
    }
    
    private func subsribeToSearchPublisher() {
        $searchedCountry
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] enteredText in
                guard let self = self else { return }
                if enteredText == "" {
                    self.fetchedCountries = nil
                    return
                }
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
            })
            .store(in: &cancellables)
    }
    
    private func subsribeToFilterTypePublisher() {
        $filterType
            .dropFirst()
            .sink { [weak self] type in
                guard let self = self,
                      let fetchedCountries = fetchedCountries
                else { return }
                self.filterSort(type: type, collection: fetchedCountries)
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToOrderPublisher() {
        $order
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.fetchedCountries?.reverse()
            }
            .store(in: &cancellables)
    }
    
    private func filterSort(type: Filter, collection: [Country]) {
        func compare<T: Comparable>(v1: T, v2: T, order: OrderFilter) -> () -> Bool {
            return {
                (order == .descending ? v1 : v2) < (order == .ascending ? v1 : v2)
            }
        }
        
        switch type {
        case .alphabetic:
            self.fetchedCountries = collection.sorted { compare(v1: $0.name.common, v2: $1.name.common, order: order)() }
        case .population:
            self.fetchedCountries = collection.sorted { compare(v1: $0.population, v2: $1.population, order: order)() }
        case .surface:
            self.fetchedCountries = collection.sorted { compare(v1: $0.area, v2: $1.area, order: order)() }
        }
    }
}
