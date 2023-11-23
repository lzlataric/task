//
//  CountryDetailView.swift
//  EvolutionTask
//
//  Created by Luka on 21.11.2023..
//

import SwiftUI

struct CountryDetailView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel
    @State var borderCountries: [Country] = []
    var country: Country
    
    var body: some View {
        VStack {
            AsyncImage(url:URL(string: country.coatOfArms.png)) { image in
                image
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .frame(width: 200, height: 200)
            }
            
            Text(country.name.official)
                .font(.largeTitle)
            
            CountryItemView(title: "\(AppStyle.Texts.languages):", text: country.languages?.getListFromDictionary().joined(separator: ", ") ?? AppStyle.Texts.unknown)
            
            CountryItemView(title: "\(AppStyle.Texts.timezones):", text: country.timezones.joined(separator: ", "))
                        
            if !borderCountries.isEmpty {
                CountryItemView(title: "\(AppStyle.Texts.neighbours):")
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(borderCountries.indices, id: \.self) { index in
                        NavigationLink {
                            CountryDetailView(country: borderCountries[index])
                                .environmentObject(countryViewModel)
                        } label: {
                            Text(borderCountries[index].cca3)
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 2)
                
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            Link(AppStyle.Texts.googleMapsInfo, destination: (URL(string: country.maps.googleMaps)!))
                .foregroundColor(.blue)
        }
        .onAppear {
            Task {
                borderCountries = try await countryViewModel.getCountryByCode(countryCodes: country.borders ?? [])
            }
        }
    }
}
