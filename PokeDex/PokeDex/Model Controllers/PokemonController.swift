//
//  PokemonController.swift
//  PokeDex
//
//  Created by Mitch Merrell on 8/14/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PokemonController {
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        
        // unwrap url
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { completion(nil); return }
        
        // url + search term
        let fullURL = baseURL.appendingPathComponent(searchTerm)
        print(fullURL)
        
        //create request from url
        let request = URLRequest(url: fullURL)
        
        // create session from request
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // unwrap error
            if let error = error {
                completion(nil)
                print("Error! \(error): \(error.localizedDescription)")
            }
            
            // unwrap data
            guard let data = data else { completion(nil); return }
            
            // decode a PokemonObject from data
            
            do {
                let jsonDecoder = JSONDecoder()
                let pokemonObject = try jsonDecoder.decode(PokemonObject.self, from: data)
                
                // turn PokemonObject into a Pokemon
                
                if let pokemon = Pokemon(pokemonObject: pokemonObject) {
                    
                    // if successful, complete with Pokemon
                    completion(pokemon)
                }

            } catch let error {
                print("Error decoding Pokemon | \(error): \(error.localizedDescription)")
                completion(nil)
            }
            
            
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        
        // url from pokemon
        guard let spriteURL = URL(string: pokemon.spriteURL) else { completion(nil); return }
        print(spriteURL)
        
        // url session (build in request defaults to GET
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            
            // check for error
            if let error = error { completion(nil); print(error); return }
            
            // check for data
            guard let data = data else { completion(nil); return }
            
            // decode data for image
            guard let sprite = UIImage(data: data) else { completion(nil); return }
            
            // if successful, complete with sprite
            completion(sprite)
            
        }.resume()
    }
}
