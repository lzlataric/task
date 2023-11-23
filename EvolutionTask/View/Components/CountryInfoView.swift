//
//  CountryInfoView.swift
//  EvolutionTask
//
//  Created by Luka on 23.11.2023..
//

import SwiftUI

struct CountryInfoView: View {
    var image: Image
    var text: String
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(text)
                .font(.footnote)
            Spacer()
        }
    }
}
