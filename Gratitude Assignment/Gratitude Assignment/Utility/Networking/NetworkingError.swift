//
//  NetworkingError.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation

public enum NetworkingError:Error,CustomErrorAlertProtocol{
    case badURL
    case badResponse(response:String)
    case decodingFailed
    case unknownError
    
    case encodingFailed
    
    public var alertTitle:String{
        switch self {
        case .badURL:
            return "Bad URL"
        case .badResponse:
            return "Bad Response"
        case .decodingFailed:
            return "Decoding Failed"
        case .unknownError:
            return "Unknown Error"
        case .encodingFailed:
            return "Encoding Failed"
        }
    }
    
    public var alertDescription:String{
        switch self {
        case .badURL,.badResponse,.decodingFailed,.unknownError,.encodingFailed:
            return "Contact Developer"
        }
    }
}
