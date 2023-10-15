//
//  ImageLoaderViewModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import Foundation
import UIKit

class ImageLoaderViewModel:ObservableObject{
    
    @Published var isLoading:Bool = false
    @Published var image:UIImage? = nil
    
    let urlString:String
    let cacheKey:String
    
    private let manager = CacheManager.instance
    private let networkingService: NetworkingService
    
    init(networkingService:NetworkingService = NetworkingService(),urlString:String,cacheKey:String){
        self.urlString = urlString
        self.cacheKey = cacheKey
        self.networkingService = networkingService
    }
    
    @MainActor
    func getImage()async{
        if let savedImage = manager.get(key: cacheKey){
            self.image = savedImage
            print("GETTING SAVED IMAGE")
        }else{
            try? await downloadImage()
            print("DOWNLOADING IMAGE NOW")
        }
    }
    
    func downloadImage()async throws{
        await MainActor.run{ self.isLoading = true }
        let response = try await self.networkingService.downloadDataFrom(url: urlString)
        
        if let image = UIImage(data: response){
            await MainActor.run{ self.image = image }
            self.manager.add(key: self.cacheKey, value: image)
            await MainActor.run{ self.isLoading = false }
        }else{
            print("Failed to Load!")
            await MainActor.run{ self.isLoading = false }
            return
        }
        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map{UIImage(data: $0.data)}
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in
//                guard let self = self else {return}
//                self.isLoading = false
//            } receiveValue: { [weak self] returnedImage in
//                guard let self = self,let image = returnedImage else {return}
//                self.manager.add(key: self.cacheKey, value: image)
//                self.image = image
//            }
//            .store(in: &cancellables)
    }
}
