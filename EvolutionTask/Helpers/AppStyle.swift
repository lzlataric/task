//
//  AppStyle.swift
//  EvolutionTask
//
//  Created by Luka on 23.11.2023..
//

import Foundation
import SwiftUI

enum AppStyle {
    enum Images {
        static let population = Image("population")
        static let capital = Image("capital")
        static let area = Image("area")
        static let arrow = Image("arrow")
    }
    
    enum Colors {
        static let gray = Color("Gray")
    }
    
    enum Texts {
        static let search = "Search"
        static let startSearch = "Start search"
        static let filter = "Filter"
        static let unknown = "Unknown"
        static let languages = "Languages"
        static let neighbours = "Neighbours"
        static let timezones = "Timezones"
        static let googleMapsInfo = "See on Google maps"
    }
    
    enum Animations {
        static let homepageAnimation = "JSON"
    }
}
