//
//  CountryListView.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import SwiftUI

struct CountryListView: View {
    var country: Country
    var body: some View {
        ZStack {
            Color("Gray")
            VStack {
                Text(country.name.common)
                    .font(.title3)
                    .padding(.top, 5)
                
                VStack {
                    HStack(spacing: 0) {
                        VStack {
                            AsyncImage(url:URL(string: country.flags.png)) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                        }
                        .padding(.leading, 15)
                        
                        VStack {
                            Image("population")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(String(country.population))
                                .font(.footnote)
                            Spacer()
                        }.frame(width: 105)
                        
                        VStack {
                            Image("capital")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(country.capital?[0] ?? "Unknown")
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                            Spacer()
                        }
                        .frame(width: 100)
                        
                        VStack {
                            Image("area")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(String(country.area))
                                .font(.footnote)
                            Spacer()
                        }
                        .frame(width: 100)
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}
