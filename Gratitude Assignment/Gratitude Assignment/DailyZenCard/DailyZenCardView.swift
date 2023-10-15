//
//  DailyZenCardView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import SwiftUI

struct DailyZenCardView: View {
    let cardContent:CardModel
    @State private var renderedImg:Image?
    @State private var isBookmarked:Bool = false
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10){

            //MARK: Image
            ImageLoaderView(urlString: cardContent.imageURL, cacheKey: cardContent.uniqueID, placeHolderImage: "placeholder-image")
            
            //MARK: Content
            VStack(alignment: .leading,spacing: 20){
                VStack(alignment: .leading){
                    Text(cardContent.title) //Theme Title
                        .font(.headline)
                        .bold()
                    
                    Text(cardContent.auther) //Auther
                        .font(.subheadline)
                }
                
                //Text
                Text(cardContent.text)
                    .font(.callout)
            }
            
            //MARK: Footer
            HStack{
                //Share Button
                ShareLink(Text(""),
                          item: cardContent.sharePrefix,
                          subject: Text(cardContent.title),
                          message: Text(cardContent.primayCTAText),
                          preview: SharePreview(Text(cardContent.primayCTAText), icon: Image(systemName: "gear.fill")))
                .tint(.green)

                
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.pink)
                    .onTapGesture {
                        withAnimation {
                            self.isBookmarked.toggle()
                        }
                    }
            }.frame(maxWidth: .infinity,alignment: .trailing)
            
            
            /*
             ShareLink(
                       item: cardContent.sharePrefix,
                       subject: Text(cardContent.title),
                       message: Text(cardContent.primayCTAText)) {
                 Image(systemName: "square.and.arrow.up")
                     .tint(.green)
             }
             */
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct DailyZenCardView_Previews: PreviewProvider {

    static var previews: some View {
        DailyZenCardView(cardContent: CardModel(uniqueID: "",
                                                title: "Quote of the Day",
                                                auther: "Rebecca Wells", text: "Life is short, but it is wide. This too shall pass.",
                                                imageURL: "https://d3ez3n6m1z7158.cloudfront.net/exp/story_976.png",
                                                primayCTAText: "Add Affirmation",
                                                sharePrefix: "Here's a lovely affirmation from my Gratitude app 🌻 https://gratefulness.page.link/3T7N")
                                                )
    }
}
