//
//  PersistenceManager.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 3/7/22.
//

import Foundation

enum UserDefaultsKeys: String {
    case favorites = "favorites"
}

class UserDefaultsManager {
    
    /**
     Saves an object of the generic type `T` to UserDefaults using the specified key.

     - Parameters:
         - object: The object to save.
         - key: The key to use to store the object in UserDefaults.

     - Precondition: `T` must conform to the `Codable` protocol.
     
     - Postcondition: The object is encoded using JSONEncoder and saved to UserDefaults using the
     specified key.
    */
    static func save<T: Codable>(_ object: T, forKey key: UserDefaultsKeys) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    /**
     Retrieves an object of the generic type `T` from UserDefaults using the specified key.

     - Parameters:
         - key: The key to use to retrieve the object from UserDefaults.

     - Returns: The decoded object of type `T`, or `nil` if no object was found for the specified key.

     - Precondition: `T` must conform to the `Codable` protocol.

     - Postcondition: The data for the specified key is retrieved from UserDefaults, decoded using
     JSONDecoder, and returned as an object of type `T`.
    */
    static func get<T: Codable>(forKey key: UserDefaultsKeys) -> T? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        
        return nil
    }
    
    /**
     Deletes the object stored in UserDefaults for the specified key.

     - Parameters:
         - key: The key used to identify the object to delete from UserDefaults.

     - Postcondition: The object associated with the specified key is removed from UserDefaults, if it exists.

     - Note: If no object is found for the specified key, no action is taken and no error is thrown.
     */
    static func delete(forKey key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
