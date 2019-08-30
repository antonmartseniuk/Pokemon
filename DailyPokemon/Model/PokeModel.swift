//
//  PokeModel.swift
//  DailyPokemon
//
//  Created by Anton Martsenyuk on 8/6/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import Foundation


struct PokeModel: Codable {
    var pokemons: [Poke]
}

struct Poke: Codable {
    let name: String
    let img: String
    let type: [String]
    let height: String
    let weight: String
    let weaknesses: [String]
}
