//
//  ContentView.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var countryViewModel = CountryViewModel()
    @State var animationFinished = false
    var body: some View {
        VStack {
            if animationFinished {
                SearchView()
            } else {
                LottieView(animationFileName: "JSON", loopMode: .playOnce)
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    self.animationFinished = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
