//
//  Logger.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation

///Logs Msg or Error to Terminal
public struct Logger{
    
    public static func logMessage(_ completion:@autoclosure (()->(String)) ){
        print("[LOG] \(completion()) \n")
    }
    
    public static func logError(_ completion:@autoclosure (()->(String)) ){
        print("\n [ERROR] \(completion()) \n")
    }
    
    public static func logWarning(_ completion:@autoclosure (()->(String)) ){
        print("\n [WARNING] \(completion()) \n")
    }
    
    public static func logLine(){
        print("\n------------------------------------\n")
    }
}
