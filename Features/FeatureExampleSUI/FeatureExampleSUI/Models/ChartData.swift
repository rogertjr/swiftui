//
//  ChartData.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import Foundation

struct ChartData: Identifiable, Equatable {
    let type: String
    let count: Int

    var id: String { return type }
    
    static func exampleData() -> [ChartData] {
        [ChartData(type: "fish", count: 10),
         ChartData(type: "reptils", count: 21),
         ChartData(type: "bird", count: 18),
         ChartData(type: "dog", count: 40),
         ChartData(type: "cat", count: 65)]
    }
}

struct HeatData: Identifiable {
    let locationX: Int
    let locationY: Int
    let temperatur: Double
    let id = UUID()

    static func exampleData() -> [HeatData] {
        [HeatData(locationX: 50, locationY: 50, temperatur: 23.0),
         HeatData(locationX: 50, locationY: 100, temperatur: 15.0),
         HeatData(locationX: 50, locationY: 150, temperatur: 25.0),
         HeatData(locationX: 50, locationY: 200, temperatur: 22.5),

         HeatData(locationX: 100, locationY: 50, temperatur: 20.0),
         HeatData(locationX: 100, locationY: 100, temperatur: 26.5),
         HeatData(locationX: 100, locationY: 150, temperatur: 29.4),
         HeatData(locationX: 100, locationY: 200, temperatur: 17.0),

         HeatData(locationX: 150, locationY: 50, temperatur: 24.0),
         HeatData(locationX: 150, locationY: 100, temperatur: 23.5),
         HeatData(locationX: 150, locationY: 150, temperatur: 21.5),
         HeatData(locationX: 150, locationY: 200, temperatur: 15.0),

         HeatData(locationX: 200, locationY: 50, temperatur: 10.0),
         HeatData(locationX: 200, locationY: 100, temperatur: 26.5),
         HeatData(locationX: 200, locationY: 150, temperatur: 27.0),
         HeatData(locationX: 200, locationY: 200, temperatur: 17.0)
        ]
    }
}

struct PetData: Identifiable {
    let id = UUID()
    let year: Int
    let population: Double
}

struct PetDataSeries: Identifiable {
    let type: String
    let petData: [PetData]
    var id: String { type }
}


let catData: [PetData] = [PetData(year: 2000, population: 6.8),
                          PetData(year: 2010, population: 8.2),
                          PetData(year: 2015, population: 12.9),
                          PetData(year: 2022, population: 15.2)]
let dogData: [PetData] = [PetData(year: 2000, population: 5),
                          PetData(year: 2010, population: 5.3),
                          PetData(year: 2015, population: 7.9),
                          PetData(year: 2022, population: 10.6)]
