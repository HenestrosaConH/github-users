//
//  ImageManager.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 1/3/23.
//

import UIKit

class ImageManager {
    
    private static func getApplicationSupportURL() -> URL {
        let fileManager = FileManager.default
        return try! fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
    }
    
    static func save(with name: String, image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
                try imageData.write(to: fileURL)
                print("Image saved to \(fileURL)")
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }

    static func get(for name: String) throws -> UIImage {
        let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
        let imageData = try Data(contentsOf: fileURL)
        return UIImage(data: imageData)!
    }

    static func deleteAll() {
        do {
            let fileURLs = getApplicationSupportURL().pathComponents.filter { $0.contains(".jpg") }
            try fileURLs.forEach { try FileManager.default.removeItem(atPath: $0) }
            print("All images deleted")
        } catch {
            print("Error deleting all images: \(error)")
        }
    }
    
    static func delete(for name: String) {
        do {
            let fileURL = getApplicationSupportURL().appendingPathComponent("\(name).jpg")
            try FileManager.default.removeItem(at: fileURL)
            print("Image deleted from \(fileURL)")
        } catch {
            print("Error deleting image: \(error)")
        }
    }

}
