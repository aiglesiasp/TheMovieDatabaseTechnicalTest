//
//  MovieService.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import Foundation

protocol MovieServiceProtocol {
    func getPopularMovies(request: MovieRequest) async throws -> PopularMovies
    func getTopRatedMovies(request: MovieRequest) async throws -> PopularMovies
    func searchMovies(request: MovieRequest) async throws -> PopularMovies
}

class MovieService: MovieServiceProtocol {
    var networRequester: NetworkRequester
    
    init(networRequester: NetworkRequester = .init()) {
        self.networRequester = networRequester
    }
    
    func getPopularMovies(request: MovieRequest) async throws -> PopularMovies {
        try await networRequester.doRequest(request: request)
    }
    
    func getTopRatedMovies(request: MovieRequest) async throws -> PopularMovies {
        try await networRequester.doRequest(request: request)
    }
    
    func searchMovies(request: MovieRequest) async throws -> PopularMovies {
        try await networRequester.doRequest(request: request)
    }
    
    
}
