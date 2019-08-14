//
//  Pokemon.swift
//  PokeDex
//
//  Created by Mitch Merrell on 8/14/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

struct Pokemon {
    
    let name: String
    let id: Int
    let weight: Int
    let height: Int
    
    let spriteURL: String
    let types: [String]
    
}

// We're using this extension so we don't lose the built-in initializer for structs, which we would if we made a custom init
extension Pokemon {
    
    init?(pokemonObject: PokemonObject) {
        
        self.name = pokemonObject.name
        self.id = pokemonObject.id
        self.weight = pokemonObject.weight
        self.height = pokemonObject.height
        
        self.spriteURL = pokemonObject.spriteURLs.frontDefaultURL
        
        // since a pokemon can have multiple types, we need to pull each type's name out of the PokemonObject.types' type object
        
        // create empty placeholder for type names
        var types = [String]()
        
        // loop through all decoded types
        for typeObject in pokemonObject.types {
            
            // append type name to placeholder
            types.append(typeObject.type.name)
        }
        
        // init with types
        self.types = types
    }
}
