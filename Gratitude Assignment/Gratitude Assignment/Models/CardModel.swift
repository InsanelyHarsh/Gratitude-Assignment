//
//  CardModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation
import SwiftUI

struct CardModel{
    let uniqueID:String
    
    let title:String
    let auther:String
    let text:String
    
    let articleURL:String
    let imageURL:String
    
    let primayCTAText:String
    let sharePrefix:String
}

/*
 {
         "text": "Life is short, but it is wide. This too shall pass.",
         "author": "Rebecca Wells",
         "uniqueId": "3ba09528-8e90-4abd-81c4-be98ee794f24",
         "type": "quote",
         "dzType": "share",
         "language": "en",
         "bgImageUrl": "https://d3ez3n6m1z7158.cloudfront.net/exp/dz_bg_27.jpg",
         "theme": "Quote",
         "themeTitle": "Quote of the Day",
         "articleUrl": "",
         "dzImageUrl": "https://d3ez3n6m1z7158.cloudfront.net/exp/quote_976.png",
         "primaryCTAText": "Share With Friends",
         "sharePrefix": "Here's a beautiful quote from my Gratitude app to brighten your day 😇 https://gratefulness.page.link/yqbs"
 }
 */
