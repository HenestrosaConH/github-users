//
//  Bundle+Ext.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 1/3/23.
//

import Foundation

extension Bundle {
    var appName: String { getInfo("CFBundleName") }
    var displayName: String { getInfo("CFBundleDisplayName") }
    var language: String { getInfo("CFBundleDevelopmentRegion") }
    var identifier: String { getInfo("CFBundleIdentifier") }
    var copyright: String {
        getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")
    }
    
    var appBuild: String { getInfo("CFBundleVersion") }
    var appVersion: String { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
