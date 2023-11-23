//
//  CountryItemView.swift
//  EvolutionTask
//
//  Created by Luka on 23.11.2023..
//

import SwiftUI

struct CountryItemView: View {
    var title: String
    var text: String? = nil
    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .font(.headline)
            Spacer()
        }
        .padding(.leading, 10)
        .padding(.top, 5)
        
        if let text {
            HStack {
                Text(text)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 2)
        }
    }
}
