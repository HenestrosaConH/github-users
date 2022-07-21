//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import Foundation

enum PersistenceActionType {
    case add
    case remove
}

// It's an enum instead of a struct because this only contains static properties and methods
struct PersistenceManager {
    
    static let shared = PersistenceManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    func update(with favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> ()) {
        retrieveFavorites { result in
            switch result {
            case .success(var retrievedFavorites):
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyAdded)
                        return
                    }
                    retrievedFavorites.append(favorite)
                
                case .remove:
                    retrievedFavorites.removeAll { follower in
                        follower == favorite
                    }
                    // Same as retrievedFavorites.removeAll { $0 == favorite }
                }
                
                completed(save(favorites: retrievedFavorites))
            
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
