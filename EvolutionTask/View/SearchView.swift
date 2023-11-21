//
//  SearchView.swift
//  EvolutionTask
//
//  Created by Luka on 21.11.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var countryViewModel = CountryViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("Search", text: $countryViewModel.searchedCountry)
                
                HStack {
                    Picker("Filter", selection: $countryViewModel.filterType) {
                        ForEach(Filter.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 300)
                    Spacer()
                    
                    Image(countryViewModel.order.rawValue)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            countryViewModel.order.toggle()
                        }
                }
                
                Spacer()
                ScrollView {
                    ForEach(countryViewModel.fetchedCountries ?? []) { country in
                        NavigationLink {
                            CountryDetailView(country: country)
                                .environmentObject(countryViewModel)
                        } label: {
                            CountryListView(country: country)
                                .frame(width: 380, height: 130)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.top, 5)
            }
            .padding()
        }
        .accentColor(.black)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
