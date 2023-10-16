//
//  SharePreviewViewModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 16/10/23.
//

import Foundation
import SwiftUI

class SharePreviewViewModel:NSObject,ObservableObject{
    
    let cacheManager:CacheManager
    
    public init(cacheManager: CacheManager = CacheManager.instance) {
        self.cacheManager = cacheManager
    }
    
    public func saveImagetoGallery(_ inputImage:UIImage)->Bool{
        UIImageWriteToSavedPhotosAlbum(inputImage, self, #selector(saveCompleted), nil)
        return true
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished to Gallery")
    }
    
    
    func shareToWhatsApp() {
        if let whatsappURL = URL(string: "whatsapp://app") {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                let text = "Hello, this is my message for WhatsApp!"
                let url = URL(string: "https://www.example.com") // Optional: You can provide a link to share
                let objectsToShare: [Any] = [text, url as Any]
                let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityViewController.excludedActivityTypes = [UIActivity.ActivityType.mail]
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            } else {
                // Handle WhatsApp not installed on the device
            }
        }
    }
    
    
    func shareToInstagram() {
        if let instagramURL = URL(string: "instagram://app") {
            if UIApplication.shared.canOpenURL(instagramURL) {
                // Make sure to create an image to share on Instagram and provide the file URL
                let image = UIImage(named: "your_image_name")
                let imageFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("image.ig")
                do {
                    try image?.jpegData(compressionQuality: 1.0)?.write(to: imageFileURL)
                } catch {
                    // Handle error
                }
                let objectsToShare: [Any] = [imageFileURL]
                let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityViewController.excludedActivityTypes = [UIActivity.ActivityType.mail]
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            } else {
                // Handle Instagram not installed on the device
            }
        }
    }
}
