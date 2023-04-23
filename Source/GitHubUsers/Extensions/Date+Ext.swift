//
//  Date+Ext.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 3/7/22.
//
import Foundation

extension Date {
    
    func toString(with formattingType: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = formattingType
        
        return formatter.string(from: self)
    }
    
}
