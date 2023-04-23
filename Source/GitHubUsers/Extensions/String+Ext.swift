//
//  String+Ext.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 29/7/22.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
}
