//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/"
    let imageCache = NSCache<NSString, UIImage>()
    
    private init () {}
    
    // Notice that T has a type constraint that requires it to be a subclass of Codable.
    func fetchData<T: Codable>(endpoint: String, completed: @escaping (Result<T, GFError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completed(.failure(.uncompletedRequest))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                // convertFromSnakeCase lets the variables named in camelCase to match with the snake_case ones obtained from the API. For example, imageUrl will match with image_url.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // According to GitHub's API documentation, all timestamps are returned in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode(T.self, from: data)
                completed(.success(decodedData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        fetchData(endpoint: endpoint, completed: completed)
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "users/\(username)"
        fetchData(endpoint: endpoint, completed: completed)
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage) -> ()) {
        // First, we check if we already have the avatar image for this particular user. If so, we'll use it instead of making another request to the API.
        let cacheKey = NSString(string: urlString)
        if let image = imageCache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // We do not handle errors here because if something went wrong, then we'll show the placeholder image instead.
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.imageCache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
    
}
