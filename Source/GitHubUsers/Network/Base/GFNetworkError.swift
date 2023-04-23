//
//  GFRequestErrors.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 22/7/22.
//

import Foundation

enum GFNetworkError: Error {
    case uncompletedRequest
    case invalidResponse
    case invalidData
    case unauthorized
    case unexpectedStatusCode
    case noResponse
    
    var title: String {
        switch self {
        case .uncompletedRequest, .invalidResponse, .invalidData, .unauthorized, .unexpectedStatusCode, .noResponse:
            return "title_generic_error".localized()
        }
    }
    
    var description: String {
        switch self {
        case .uncompletedRequest:
            return "description_generic_network_error".localized()
        case .invalidResponse:
            return "description_invalid_response".localized()
        case .invalidData:
            return "description_invalid_data".localized()
        case .unauthorized:
            return "description_unauthorized".localized()
        case .unexpectedStatusCode:
            return "description_unexpected_status_code".localized()
        case .noResponse:
            return "description_no_response".localized()
        }
    }
}
