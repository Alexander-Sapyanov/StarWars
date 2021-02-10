//
//  Films.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
