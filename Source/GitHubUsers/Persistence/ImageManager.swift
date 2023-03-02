//
//  ImageManager.swift
//  GitHubUsers
//
//  Created by JC on 1/3/23.
//

import UIKit

class ImageManager {
    
    // MARK: - Static Methods
    
    static func saveImage(name: String, image: UIImage) {
        // Check if it already exists
        do {
            let _ = try retrieveImage(for: name)
            return
        } catch {}

        // Convert the image to JPEG data
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                try ImageHelper.saveImageData(imageData: imageData, name: name)
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }

    static func retrieveImage(for name: String) throws -> UIImage {
        let imageData = try ImageHelper.getImageData(name: name)
        return UIImage(data: imageData)!
    }

    static func deleteImage(name: String) {
        do {
            try ImageHelper.deleteImage(name: name)
        } catch {
            print("Error deleting image: \(error)")
        }
    }

}
