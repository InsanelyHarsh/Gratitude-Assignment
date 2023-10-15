//
//  CacheManager.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import Foundation
import UIKit

class CacheManager{
    
    static let instance = CacheManager()
    private init(){}
    
    var photoCache:NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key:String,value:UIImage){
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key:String) -> UIImage?{
        guard let value = photoCache.object(forKey: key as NSString) else {
            return nil
        }
        return value
    }
}
