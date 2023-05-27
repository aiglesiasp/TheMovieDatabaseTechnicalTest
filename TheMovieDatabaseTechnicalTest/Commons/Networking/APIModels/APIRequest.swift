//
//  APIRequest.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import Foundation

protocol APIRequest {
    var url: URL? { get }
    var path: APIPath { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    // Default values
    var url: URL? { ServicesURL.baseURL.convertedURL }
    var queryItems: [URLQueryItem]? { nil }
    var method: HTTPMethod { .get }
}
