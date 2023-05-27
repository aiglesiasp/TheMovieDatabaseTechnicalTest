//
//  FavoritesViewModel.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 26/5/23.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoritesMovies: [Movie] = []
    private var repository: Repository
    
    init(repository: Repository = AppRepository.shared) {
        self.repository = repository
    }
    
    func getFavoriteMovies() {
        let favorites = repository.load(forKey: StorageKeys.KEY_FAVORITES, as: [Movie].self)
        favoritesMovies = favorites ?? []
    }
    
    func delete(at offsets: IndexSet) {
        var favorites = favoritesMovies
        favorites.remove(atOffsets: offsets)
        repository.store(favorites, key: StorageKeys.KEY_FAVORITES)
    }
}
