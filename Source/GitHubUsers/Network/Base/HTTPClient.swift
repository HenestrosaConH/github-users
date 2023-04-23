//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 29/6/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async -> Result<T, GFNetworkError>
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async -> Result<T, GFNetworkError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidData)
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                
                // convertFromSnakeCase lets the variables named in camelCase to match with the snake_case ones obtained from the API. For example, imageUrl will match image_url.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // According to GitHub's API documentation, all timestamps are returned in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
                decoder.dateDecodingStrategy = .iso8601
                
                guard let decodedResponse = try? decoder.decode(responseType, from: data) else {
                    return .failure(.invalidData)
                }
                
                return .success(decodedResponse)
            
            case 401:
                return .failure(.unauthorized)
            
            default:
                print("Unexpected HTTP error code: \(response.statusCode)")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.invalidData)
        }
    }
    
}
