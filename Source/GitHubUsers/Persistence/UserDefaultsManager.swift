//
//  PersistenceManager.swift
//  GitHubUsers
//
//  Created by JC on 3/7/22.
//

import UIKit

enum UserDefaultsManagerActionType {
    case add
    case remove
}

// It's an enum instead of a struct because this only contains static properties and methods
struct UserDefaultsManager {
    
    // MARK: - Public Enums
    enum Keys {
        static let favorites = "favorites"
    }
    
    // MARK: - Private Properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Static Properties
    static let shared = UserDefaultsManager()
    
    
    // MARK: - Initializers
    
    private init() {}
    
    
    // MARK: - Public Methods
    
    func update(with favorite: User, actionType: UserDefaultsManagerActionType, completed: @escaping (GFPersistenceError?) -> ()) {
        retrieveFavorites { result in
            switch result {
            case .success(var retrievedFavorites):
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        print("Already added")
                        return
                    }
                    retrievedFavorites.append(favorite)
                    if let avatarImage = favorite.avatarImage {
                        ImageManager.saveImage(name: favorite.username, image: avatarImage)
                    }
                
                case .remove:
                    retrievedFavorites.removeAll { $0 == favorite }
                    ImageManager.deleteImage(name: favorite.username)
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                print(error.localizedDescription)
                completed(error)
            }
        }
    }
    
    func retrieveFavorites(completed: @escaping (Result<[User], GFPersistenceError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([User].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            print("Retrieve favorites: \(error.localizedDescription)")
            completed(.failure(.unableToFavorite))
        }
    }
    
    func isUserInFavorites(username: String) -> Result<Bool, GFPersistenceError> {
        guard let favoritesData = UserDefaults.standard.data(forKey: Keys.favorites) else {
            return .success(false)
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([User].self, from: favoritesData)
            return .success(favorites.contains { $0.username == username })
        } catch {
            print("isUserInFavorites: \(error.localizedDescription)")
            return .failure(.unableToFavorite)
        }
    }
    
    func save(favorites: [User]) -> GFPersistenceError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        } catch {
            print("save: \(error.localizedDescription)")
            return .unableToFavorite
        }
    }
    
}
