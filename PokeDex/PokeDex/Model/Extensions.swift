//
//  Extensions.swift
//  PokeDex
//
//  Created by Mitch Merrell on 8/14/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
