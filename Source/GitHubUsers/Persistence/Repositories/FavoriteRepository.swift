//
//  FavoriteRepository.swift
//  GitHubUsers
//
//  Created by JC on 5/3/23.
//

import UIKit

class FavoriteRepository: Repository {
    
    func save(object: User) {
        var favorites = UserDefaultsManager.get(forKey: .favorites) as [User]? ?? []
        favorites.append(object)
        UserDefaultsManager.save(favorites, forKey: .favorites)
        ImageManager.save(with: object.username, image: object.avatarImage ?? UIImage())
    }
    
    func getAll() -> [User] {
        return UserDefaultsManager.get(forKey: .favorites) as [User]? ?? []
    }
    
    func get(objectWith id: String) -> User? {
        if let favorites = UserDefaultsManager.get(forKey: .favorites) as [User]? {
            return favorites.first(where: { $0.username == id })
        }
        
        return nil
    }
    
    func update(objectWith id: String, to newObject: User) -> Bool {
        if var favorites = UserDefaultsManager.get(forKey: .favorites) as [User]?,
           let index = favorites.firstIndex(where: { $0.username == id })
        {
            favorites[index] = newObject
            ImageManager.save(with: id, image: newObject.avatarImage ?? UIImage())
            UserDefaultsManager.save(favorites, forKey: .favorites)
            
            return true
        }
        
        return false
    }
    
    func deleteAll() {
        UserDefaultsManager.delete(forKey: .favorites)
        ImageManager.deleteAll()
    }
    
    func delete(objectWith id: String) -> Bool {
        if var favorites = UserDefaultsManager.get(forKey: .favorites) as [User]?,
           let index = favorites.firstIndex(where: { $0.username == id })
        {
            favorites.remove(at: index)
            ImageManager.delete(for: id)
            UserDefaultsManager.save(favorites, forKey: .favorites)
            
            return true
        }
        
        return false
    }
    
}
