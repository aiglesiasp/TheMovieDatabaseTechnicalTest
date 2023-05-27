//
//  HomeViewModel.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 25/5/23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var popularMovies: PopularMovies?
    @Published var topRatedMovies: PopularMovies?
    @Published var isErrorPopular: Bool = false
    @Published var isErrorTopRates: Bool = false
    @Published var searchedMovies: PopularMovies?
    @Published var query = ""
    
    private var service: MovieServiceProtocol
    private var repository: Repository
    
    init(service: MovieServiceProtocol = MovieService(), repository: Repository = AppRepository.shared) {
        self.service = service
        self.repository = repository
    }
    
    func getMovies() async {
        do {
            guard let localpopularMovies = repository.load(forKey: StorageKeys.KEY_POPULAR_MOVIES, as: PopularMovies.self) else {
                let popularMoviesResponse: PopularMovies = try await service.getPopularMovies(request: .popularMovies)
                DispatchQueue.main.async { [weak self] in
                    self?.popularMovies = popularMoviesResponse
                }
                repository.store(popularMoviesResponse, key: StorageKeys.KEY_POPULAR_MOVIES)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.popularMovies = localpopularMovies
            }
            
        } catch {
            isErrorPopular = true
            print("Tenemos un problema")
        }
    }
    
    func getTopRatedMovies() async {

        do {
            guard let localTopRatedMoviesResponse = repository.load(forKey: StorageKeys.KEY_TOP_RATED_MOVIES, as: PopularMovies.self) else {
                let topRatedMoviesResponse: PopularMovies = try await service.getTopRatedMovies(request: .topRatedMovies)
                DispatchQueue.main.async { [weak self] in
                    self?.topRatedMovies = topRatedMoviesResponse
                }
                repository.store(topRatedMoviesResponse, key: StorageKeys.KEY_TOP_RATED_MOVIES)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.topRatedMovies = localTopRatedMoviesResponse
            }
            
        } catch {
            isErrorTopRates = true
            print("Tenemos un problema")
        }
    }
    
    func searchMoviesByName() async {
        
        do {
            let searchMoviesResponse = try await service.searchMovies(request: .movie(id: query))
            DispatchQueue.main.async { [weak self] in
                self?.searchedMovies = searchMoviesResponse
            }
        } catch {
            print("Hay coincidencias")
        }
    }
}
