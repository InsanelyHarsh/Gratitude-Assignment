//
//  DateExt.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 16/10/23.
//

import Foundation
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
    
    var getDateDescription:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        let date = Date.now.formatted(date: .numeric, time: .omitted)
        if(date == self.formatted(date: .numeric, time: .omitted)){ return "TODAY" }
        return formatter.string(from: self)
    }
}
