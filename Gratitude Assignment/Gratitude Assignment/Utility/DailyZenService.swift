//
//  DailyZenService.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation
import UIKit

struct DailyZenService{
    private var currentDate:String = ""
    private let networkingService:NetworkingService
    
    public init(networkingService: NetworkingService = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func getCards(forDate date:Date) async throws->[CardModel]{
        
        let dateString = convert(date: date) //Date --> "20230915"
        
        let url = "https://m67m0xe4oj.execute-api.us-east-1.amazonaws.com/prod/dailyzen/?date=\(dateString)&version=2"
        let result = try await self.networkingService.getJSON(url: url, type: [DailyZenModel].self)
        
        return result.map{
            CardModel(uniqueID: $0.uniqueID,
                      title: $0.themeTitle,
                      auther: $0.author,
                      text: $0.text,
//                      themeTitle: $0.themeTitle,
                      imageURL: $0.dzImageURL,
                      primayCTAText: $0.primaryCTAText,
                      sharePrefix: $0.sharePrefix)
        }
    }

    func getImageFrom(url:String)async -> UIImage?{
        do{
            let imageData = try await self.networkingService.downloadDataFrom(url: url)
            return UIImage(data: imageData)
        }catch(_){
            
        }
        return nil
    }
    
    ///Converts Date into yyyMMdd
    private func convert(date:Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: date)
    }
}
