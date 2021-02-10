//
//  Characters.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 10.02.2021.
//

import Foundation


struct Character: Codable {
    let birthYear: String
    let eyeColor: String
    let films: [String]
    let gender: String
    let hairColor: String
    let height: String
    let homeWorld: String
    let mass: String
    let name: String
    let skinColor: String
    let created: String
    let edited: String
    let species: [String]
    let starships: [String]
    let url: String
    let vehicles: [String]
  
    
    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case films = "films"
        case gender = "gender"
        case hairColor = "hair_color"
        case height = "height"
        case homeWorld = "homeworld"
        case mass = "mass"
        case name = "name"
        case skinColor = "skin_color"
        case created = "created"
        case edited = "edited"
        case species = "species"
        case starships = "starships"
        case url = "url"
        case vehicles = "vehicles"
    }
}
