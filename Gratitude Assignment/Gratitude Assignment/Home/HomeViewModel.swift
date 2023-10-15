//
//  HomeViewModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation
import SwiftUI


class HomeViewModel:ObservableObject{
    @Published var zenCards:[CardModel] = []
    
    @Published var isLoading:Bool = false
    @Published var isPrevButtonDisabled:Bool = false
    @Published var isNextButtonDisabled:Bool = true
    
    private var currentDate = Date.now
    private let dailyZenService:DailyZenService
    
    public init(dailyZenService: DailyZenService = DailyZenService()) {
        self.dailyZenService = dailyZenService
    }
    
    public func getDailyZenCard() async{
        await MainActor.run{
            withAnimation {
                self.isLoading = true
            }
        }
        let response = try! await self.dailyZenService.getCards(forDate: currentDate)
        
        await MainActor.run{
            self.zenCards = response.map{CardModel(uniqueID: $0.uniqueID,
                                                   title: $0.themeTitle,
                                                   auther: $0.author,
                                                   text: $0.text,
                                                   imageURL: $0.dzImageURL,
                                                   primayCTAText: $0.primaryCTAText,
                                                   sharePrefix: $0.sharePrefix
                                                   )}
            
//            CacheManager.instance.add(key: currentDate.description, value: <#T##UIImage#>)
            
            withAnimation {
                self.isLoading = false
            }
        }
    }
    
    public func getNextDayCard()async{
        let date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

        if(await isValidDate(date)){
            self.currentDate = date
        }
        
        await self.getDailyZenCard()
    }
    
    public func getPrevDayCard()async{
        let date = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        
        if(await isValidDate(date)){
            self.currentDate = date
        }
        
        await self.getDailyZenCard()
    }
    
    
//    public func get
}

extension HomeViewModel{
    @MainActor
    private func isValidDate(_ date:Date)->Bool{
        let dayGap = daysBetween(startDate: date, endDate: Date.now)
        
        if(dayGap == 7){
            self.isPrevButtonDisabled = true
            self.isNextButtonDisabled = false
        }else if(dayGap == 0){
            self.isNextButtonDisabled = true
            self.isPrevButtonDisabled = false
        }else{
            self.isNextButtonDisabled = false
            self.isPrevButtonDisabled = false
        }
        return dayGap > 0 && dayGap <= 7
    }
    
    private func daysBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        
        // Get the start and end of the day for each date.
        let startOfDay = calendar.startOfDay(for: startDate)
        let endOfDay = calendar.startOfDay(for: endDate)
        
        // Calculate the difference between the two dates in days.
        let days = calendar.dateComponents([.day], from: startOfDay, to: endOfDay).day!
        
        return days
    }
}
