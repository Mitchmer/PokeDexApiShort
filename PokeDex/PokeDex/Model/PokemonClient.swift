//
//  PokemonClient.swift
//  PokeDex
//
//  Created by Mitch Merrell on 8/14/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

// MARK: Top Level

struct PokemonObject: Decodable {
    
    // Top Level
    let name: String
    let id: Int
    let weight: Int
    let height: Int
    
    // Second Level
    let spriteURLs: SpriteObject
    let types: [TypeObjectParent]
    
    // Coding Keys
    private enum CodingKeys: String, CodingKey {
        
        // name, id, etc. NEED to be here or they won't get initialized
        case name, id, weight, height, types
        case spriteURLs = "sprites"
    }
}

// MARK: Second Level

struct SpriteObject: Decodable {
    
    let frontDefaultURL: String
    
    private enum CodingKeys: String, CodingKey {
        
        case frontDefaultURL = "front_default"
    }
}

struct TypeObjectParent: Decodable {
    
    let type: TypeObjectChild
    
}

// MARK: Third Level

struct TypeObjectChild: Decodable {
    
    let name: String
}
