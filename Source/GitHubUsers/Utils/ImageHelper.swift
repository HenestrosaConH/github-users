//
//  FileHelper.swift
//  GitHubUsers
//
//  Created by JC on 1/3/23.
//

import Foundation

struct ImageHelper {
    
    // MARK: - Static Methods
    
    static func getApplicationSupportURL() -> URL {
        let fileManager = FileManager.default
        return try! fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    static func saveImageData(imageData: Data, name: String) throws {
        let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
        try imageData.write(to: fileURL)
        print("Image saved to \(fileURL)")
    }

    static func getImageData(name: String) throws -> Data {
        let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
        return try Data(contentsOf: fileURL)
    }

    static func deleteImage(name: String) throws {
        let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
        try FileManager.default.removeItem(at: fileURL)
        print("Image deleted from \(fileURL)")
    }
    
}
