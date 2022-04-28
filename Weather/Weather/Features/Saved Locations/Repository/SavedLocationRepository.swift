//
//  SavedLocationRepository.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//

import Foundation

typealias LocationResult = (Result<[Location], CustomError>) -> Void
protocol SavedLocationRepositoryType {
    
    func fetchAllSavedLocations(completion: @escaping (LocationResult))
}

class SavedLocationRepository: SavedLocationRepositoryType {
    private var locations: [Location]? = []
    
    func fetchAllSavedLocations(completion: @escaping (LocationResult)) {
        do {
            self.locations = try Constants.coreDataPersistantObject?.fetch(Location.fetchRequest())
            guard let safeLocations = self.locations else { return }
            completion(.success(safeLocations))
            
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
