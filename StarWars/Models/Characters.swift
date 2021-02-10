//
//  Characters.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 10.02.2021.
//

import Foundation

struct Characters: Decodable {
    let count: Int
    let all: [Character]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case all = "results"
    }
}
