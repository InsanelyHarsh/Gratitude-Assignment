//
//  AlertHandler.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import Foundation

struct AlertModel{
    let title:String
    let description:String
    let alertAction:()->()
    public init(title: String = "Error", description: String = "Try Again",alertAction:@escaping ()->() = { }) {
        self.title = title
        self.description = description
        self.alertAction = alertAction
    }
}

//class AlertHandler:ObservableObject{
//    @Published var alert:AlertModel = AlertModel()
//    @Published var showAlert:Bool = false
//
//    func presentAlert(_ alert:AlertModel){
//        self.alert = alert
//        self.showAlert = true
//    }
//
//    func alertAction(){
//
//    }
//}
