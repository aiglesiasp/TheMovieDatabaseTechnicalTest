//
//  AppRepository.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 27/5/23.
//

import Foundation

protocol Repository {
    func store(_ data: Encodable, key: String)
    func load<T: Decodable>(forKey key: String, as type: T.Type) -> T?
    func delete(key: String)
}

final class AppRepository: Repository {
    
    static let shared = AppRepository()
    
    private init(){}
    
    func store(_ data: Encodable, key: String) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func load<T>(forKey key: String, as type: T.Type) -> T? where T : Decodable {
        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(T.self, from: savedData)
            return decodeData
        } catch {
            return nil
        }
    }
    
    func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
