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
    private var savedLocations: [Location]?
    
    init(repository: SavedLocationRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
        savedLocations = []
    }
    
    var locationsCount: Int {
        return savedLocations?.count ?? 0
    }
    
    var locations: [Location] {
        return savedLocations ?? []
    }
    
    func allLocations() {
        repository?.fetchAllSavedLocations(completion: { [weak self] locations in
            switch locations {
            case .success(let savedLocations):
                self?.savedLocations = savedLocations
                DispatchQueue.main.async {
                    self?.delegate?.reloadView()
                }
            case .failure:
                self?.delegate?.show(error: .invalidData)
            }
        })
    }
}
