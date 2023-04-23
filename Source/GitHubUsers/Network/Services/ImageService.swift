//
//  ImageService.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 23/7/22.
//

import UIKit

protocol ImageServiceable {
    func getAvatar(from url: URL) async -> Result<UIImage, GFNetworkError>
}

struct ImageService: ImageServiceable {
    
    // MARK: - Properties
    
    private let cache = Cache<String, UIImage>()
    
    // MARK: - Methods
    
    func getAvatar(from url: URL) async -> Result<UIImage, GFNetworkError> {
        if let image = cache[url.absoluteString] {
            return .success(image)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return .failure(.invalidData)
            }
            cache.insert(image, forKey: url.absoluteString)
            return .success(image)
        } catch {
            return .failure(.invalidResponse)
        }
    }
    
}
