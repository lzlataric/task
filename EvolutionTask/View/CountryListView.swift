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
            AppStyle.Colors.gray
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
                        
                        CountryInfoView(image: AppStyle.Images.population, text: String(country.population))
                            .frame(width: 105)
                        
                        CountryInfoView(image: AppStyle.Images.capital, text: country.capital?[0] ?? AppStyle.Texts.unknown)
                            .frame(width: 100)
                        
                        CountryInfoView(image: AppStyle.Images.area, text: String(country.area))
                            .frame(width: 100)
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}
