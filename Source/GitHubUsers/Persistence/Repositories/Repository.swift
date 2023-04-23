//
//  Repository.swift
//  GitHubUsers
//
//  Created by JC on 8/4/23.
//

import Foundation

protocol Repository {
    associatedtype T

    func save(object: T)
    func getAll() -> [T]
    func get(objectWith id: String) -> T?
    func update(objectWith id: String, to newObject: T) -> Bool
    func deleteAll()
    func delete(objectWith id: String) -> Bool
}
