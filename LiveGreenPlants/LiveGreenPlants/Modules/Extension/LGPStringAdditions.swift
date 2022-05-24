//
//  LGPStringAdditions.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import Foundation

extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
    
}
