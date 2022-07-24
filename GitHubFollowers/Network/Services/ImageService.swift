//
//  ImageService.swift
//  GitHubFollowers
//
//  Created by JC on 23/7/22.
//

import UIKit

protocol ImageServiceable {
    func getAvatar(from urlString: String) async -> Result<UIImage, GFNetworkError>
}

struct ImageService: ImageServiceable {
    
    private let cache = Cache<String, UIImage>()
    
    func getAvatar(from urlString: String) async -> Result<UIImage, GFNetworkError> {
        if let image = cache[urlString] {
            return .success(image)
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidUrl)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return .failure(.invalidData)
            }
            cache.insert(image, forKey: urlString)
            return .success(image)
        } catch {
            return .failure(.invalidResponse)
        }
    }
    
}
