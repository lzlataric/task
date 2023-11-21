//
//  CountryDetailView.swift
//  EvolutionTask
//
//  Created by Luka on 21.11.2023..
//

import SwiftUI

struct CountryDetailView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel
    var country: Country
    @State var borderCountries: [Country] = []
    
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
            
            HStack(spacing: 5) {
                Text("Languages:")
                    .font(.headline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 5)
            
            HStack {
                Text(country.languages?.getListFromDictionary().joined(separator: ", ") ?? "Unknown")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 2)
            
            HStack(spacing: 5) {
                Text("Timezones:")
                    .font(.headline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 5)
            
            HStack {
                Text(country.timezones.joined(separator: ", "))
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 2)
            
            HStack(spacing: 5) {
                Text("Neighbors:")
                    .font(.headline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 5)
            
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
            
            Link("See on Google Maps", destination: (URL(string: country.maps.googleMaps)!))
                .foregroundColor(.blue)
        }
        .onAppear {
            Task {
                borderCountries = try await countryViewModel.getCountryByCode(countryCodes: country.borders ?? [])
            }
        }
    }
}
