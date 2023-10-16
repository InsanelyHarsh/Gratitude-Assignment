//
//  ImageLoaderView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import SwiftUI
import Combine

struct ImageLoaderView: View {
    @StateObject private var loader:ImageLoaderViewModel
    private let placeHolderImage:String
    
    init(urlString:String,cacheKey:String,placeHolderImage:String){
        _loader = StateObject(wrappedValue: ImageLoaderViewModel(urlString: urlString, cacheKey: cacheKey))
        
        self.placeHolderImage = placeHolderImage
    }
    
    var body: some View {
        ZStack{
            if loader.isLoading{
                Image(placeHolderImage)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        Task{
                            await self.loader.getImage()
                            Logger.logMessage("Re-Loading Image...")
                        }
                    }
            }else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
        }.task {
            await self.loader.getImage()
        }
    }
}

//struct ImageLoaderView_Previews: PreviewProvider {
//    static var previews: some View {
////        ImageLoaderView()
//        DailyZenCardView(cardContent: CardModel(uniqueID: "",
//                                                title: "Quote of the Day",
//                                                auther: "Rebecca Wells", text: "Life is short, but it is wide. This too shall pass.",
//                                                imageURL: "https://d3ez3n6m1z7158.cloudfront.net/exp/story_976.png",
//                                                primayCTAText: "Add Affirmation",
//                                                sharePrefix: "Here's a lovely affirmation from my Gratitude app 🌻 https://gratefulness.page.link/3T7N")
//                                                )
//    }
//}


