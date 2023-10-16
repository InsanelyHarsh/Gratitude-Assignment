//
//  DailyZenCardView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import SwiftUI

struct DailyZenCardView: View {
    
    let cardContent:CardModel
    @State private var isBookmarked:Bool = false
    @State private var presentSheet:Bool = false
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            
            Text(cardContent.title.uppercased())
                .foregroundColor(.cardHeaderFont)
                .padding(.vertical)
            
            //Card Image
            ImageLoaderView(urlString: cardContent.imageURL, cacheKey: cardContent.uniqueID, placeHolderImage: "placeholder-image")
            
            //Footer
            self.footer
            Spacer()
        }
        .sheet(isPresented: $presentSheet) {
            SharePreviewView(shareImage: CacheManager.instance.get(key: cardContent.uniqueID), sharePrefix: cardContent.sharePrefix, primaryCTAText: cardContent.primayCTAText)
                .presentationDetents([.fraction(0.8),.large])
        }
        .background{
            Color.cardBG.cornerRadius(10)
        }
        .padding(.horizontal)
    }
    
    
    //MARK: Footer
    private var footer:some View{
        HStack{
            
//            if(cardContent.articleURL.isEmpty == true){
//                Button {
//                    if let url = URL(string:cardContent.articleURL){
//                        UIApplication.shared.open(url)
//                    }
//                } label: {
//                    HStack{
//                        Image(systemName: "newspaper")
//                        Text("Read Full Post")
//                    }
//                }
//                .padding()
//            }
            
            Button {
                self.presentSheet.toggle()
            } label: {
                Image(systemName: "square.and.arrow.up")
            }


            Image(systemName: "plus.circle")
            
            Image(systemName: isBookmarked ? "bookmark.circle.fill" : "bookmark.circle")
                .foregroundColor(.pink)
                .onTapGesture {
                    withAnimation {
                        self.isBookmarked.toggle()
                    }
                }
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
}

//struct DailyZenCardView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DailyZenCardView(cardContent: CardModel(uniqueID: "", title: "JSO",
//                                                auther: "Rebecca Wells", text: "Life is short, but it is wide. This too shall pass.", articleURL: "",
//                                                imageURL: "https://d3ez3n6m1z7158.cloudfront.net/exp/story_976.png",
//                                                primayCTAText: "Add Affirmation",
//                                                sharePrefix: "Here's a lovely affirmation from my Gratitude app 🌻 https://gratefulness.page.link/3T7N")
//                                                )
//    }
//}
