//
//  APIPath.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import Foundation

enum APIPath {
    case popularMovies
    case topRatedMovies
    case movies(id: String)
    
    var rawValue: String {
        switch self {
        case .popularMovies: return "/3/movie/popular"
        case .topRatedMovies: return "/3/movie/top_rated"
        case .movies: return "/3/search/movie"
        }
    }
}
