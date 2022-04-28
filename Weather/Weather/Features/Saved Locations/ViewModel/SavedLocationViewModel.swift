//
//  SavedLocationViewModel.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//

import Foundation


class SavedLocationViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var repository: SavedLocationRepositoryType?
    private var savedLocations: [Location] = []
    
    init() {
        savedLocations = repository?.fetchData() ?? []
    }
    
    var locationsCount: Int {
        return savedLocations.count
    }
    
    var locations: [Location] {
        return savedLocations
    }
    
    init(repository: SavedLocationRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
}
