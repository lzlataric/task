//
//  Dictionary+Ext.swift
//  EvolutionTask
//
//  Created by Luka on 21.11.2023..
//

import Foundation

extension Dictionary where Key == String, Value == String {
    func getListFromDictionary() -> [String] {
        self.map { (_, value) in
            return value
        }
    }
}
