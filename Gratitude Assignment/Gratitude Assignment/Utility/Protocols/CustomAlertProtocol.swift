//
//  CustomAlertProtocol.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation
import SwiftUI

public protocol CustomErrorAlertProtocol{
    var alertTitle:String{
        get
    }
    
    var alertDescription:String{
        get
    }
}

extension Color{
    static var homeBG:Color{
        Color("home-bg-color")
    }
    
    static var cardHeaderFont:Color{
        Color("card-header-font-color")
    }
    
    static var cardBG:Color{
        Color("card-bg-color")
    }
    
    static var clipBoardBG:Color{
        Color("clipBoard-BG")
    }
}
