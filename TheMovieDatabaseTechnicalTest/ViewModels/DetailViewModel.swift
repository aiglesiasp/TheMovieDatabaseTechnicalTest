//
//  DetailViewModel.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 27/5/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    var movies: [Movie] = []
    private var repository: Repository
    
    init(repository: Repository = AppRepository.shared) {
        self.repository = repository
    }
    
    func saveFavorite(movie: Movie) {
        var favorites = movies
        favorites.append(movie)
        repository.store(favorites, key: StorageKeys.KEY_FAVORITES)
    }
    
    func loadFavorites() {
        let favorites = repository.load(forKey: StorageKeys.KEY_FAVORITES, as: [Movie].self) ?? []
        movies = favorites
    }
    
    func checkIfIsFavorite(movie: Movie) -> Bool {
        return movies.contains(where: {$0.id == movie.id})
    }
    
    func deleteFavorite(movie: Movie) {
        var favorites = movies
        favorites.removeAll(where: {$0.id == movie.id})
        repository.store(favorites, key: StorageKeys.KEY_FAVORITES)
    }
}
