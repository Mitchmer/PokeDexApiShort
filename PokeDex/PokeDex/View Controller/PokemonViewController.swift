//
//  ViewController.swift
//  PokeDex
//
//  Created by Mitch Merrell on 8/14/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self
    }
}

// MARK: Search bar Delegate

extension PokemonViewController: UISearchBarDelegate {
    func correctedStat(stat: Int) -> String {
        var correctedArray = String(stat).map { String($0) }
        correctedArray.insert(".", at: correctedArray.count - 1)
        return correctedArray.joined()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // clean up UI for another result
        searchBar.resignFirstResponder()
        pokemonImageView.image = nil
        
        // check for valid search term
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        // perform search
        PokemonController.fetchPokemon(searchTerm: searchTerm.lowercased()) { (pokemon) in
            
            // if there is a completion (not nil), i.e. search was successful, run the rest of the code
            guard let pokemon = pokemon else { return }
            
            // return to main thread
            
            DispatchQueue.main.async {
                // update UI to reflect new Pokemon
                self.pokemonNameLabel.text = pokemon.name.uppercased()
                self.pokemonWeightLabel.text = self.correctedStat(stat: pokemon.weight) + " kg"
                self.pokemonIDLabel.text = String(pokemon.id)
                self.pokemonHeightLabel.text = self.correctedStat(stat: pokemon.height) + " m"
                
                let capitalizedArray = pokemon.types.compactMap({ (type) -> String in
                    type.capitalizingFirstLetter()
                })
                
                self.pokemonTypeLabel.text = capitalizedArray.joined(separator: ", ")
            }
            
            // fetch sprite for new Pokemon
            
            PokemonController.fetchSprite(for: pokemon, completion: { (sprite) in
                
                // check if fetch was successful
                guard let sprite = sprite else { return }
                
                // return to main thread
                DispatchQueue.main.async {
                    self.pokemonImageView.image = sprite
                }
            })
        }
    }
}
