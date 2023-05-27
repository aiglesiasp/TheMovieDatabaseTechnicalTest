//
//  MovieRequest.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import Foundation

enum MovieRequest {
    case popularMovies
    case topRatedMovies
    case movie(id: String)
}

extension MovieRequest: APIRequest {
    var url: URL? {
        switch self {
        case .popularMovies, .movie, .topRatedMovies:
            return ServicesURL.baseURL.convertedURL
        }
    }
    
    var path: APIPath {
        switch self {
        case .popularMovies: return .popularMovies
        case .topRatedMovies: return .topRatedMovies
        case let .movie(id): return .movies(id: id)
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .popularMovies, .topRatedMovies:
            return [
                URLQueryItem(name: "api_key", value: Constants.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .movie(let id):
            return [
                URLQueryItem(name: "api_key", value: Constants.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "query", value: id)
            ]
        }
    }
}
