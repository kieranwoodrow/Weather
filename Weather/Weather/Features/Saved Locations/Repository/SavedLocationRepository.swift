//
//  SavedLocationRepository.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//

import Foundation

protocol SavedLocationRepositoryType: AnyObject {
    func fetchData() -> [Location]
}

class SavedLocationRepository: SavedLocationRepositoryType {
    
    private var items: [Location] = []
    
    func fetchData() -> [Location] {
        
        do {
            self.items = try Constants.coreDataPersistantObject?.fetch(Location.fetchRequest()) ?? []
            
        } catch {
            
        }
        return items
    }
}


