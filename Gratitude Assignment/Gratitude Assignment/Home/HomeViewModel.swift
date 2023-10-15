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
    
    @Published var datesArray:[Date] = []
    
    @Published var showAlert:Bool = false
    @Published var alert:AlertModel = AlertModel() //Default Alert
    
    @Published var currentDate = Date.now
    private let dailyZenService:DailyZenService
    
    public init(dailyZenService: DailyZenService = DailyZenService()) {
        self.dailyZenService = dailyZenService
        
        generateDates()
    }
    
    public func getDailyZenCard() async{
        
        await MainActor.run{
            withAnimation {
                self.isLoading = true
            }
        }
        
        do{
            let response = try await self.dailyZenService.getCards(forDate: currentDate)
            await MainActor.run{
                self.zenCards = response
                withAnimation {
                    self.isLoading = false
                }
            }
        }catch(let error){
            let networkingError = error as? NetworkingError
            if(networkingError != nil){
                presentAlert(alertTitle: networkingError!.alertTitle, alertMessage: networkingError!.alertDescription){
                    Task{
                        await self.getDailyZenCard()
                    }
                }
            }else{
                presentAlert(alertTitle: "Fetching Zen Cards Failed", alertMessage: error.localizedDescription){ [weak self] in
                    Task{ [weak self] in
                        await self?.getDailyZenCard()
                    }
                }
            }
        }
    }
    
    public func getNextDayCard()async{
        let date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

        if(await isValidDate(date)){
            await MainActor.run{ self.currentDate = date }
        }
        
        await self.getDailyZenCard()
    }
    
    public func getPrevDayCard()async{
        let date = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        
        if(await isValidDate(date)){
            await MainActor.run{ self.currentDate = date }
        }
        
        await self.getDailyZenCard()
    }
    
    
    private func presentAlert(alertTitle title:String, alertMessage description:String,_ action:@escaping ()->() = { }){
        self.isLoading = false
        self.alert = AlertModel(title: title, description: description,alertAction: action)
        self.showAlert = true
    }
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
    
    private func generateDates(){
        let today = Date()
        let calendar = Calendar.current
        
        var datesArray: [Date] = []
        
        for dateOffset in -6...7{
            if let date = calendar.date(byAdding: .day, value: dateOffset, to: today) {
                datesArray.append(date)
            }
        }
        self.datesArray = datesArray
    }
}

extension Date{
    var getDay:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    var getMonth:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
}
