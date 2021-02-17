//
//  NewCharacters.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 16.02.2021.
//

import Foundation
struct NewCharacters: Decodable {
    let count: Int
    let all: [NewCharacter]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
