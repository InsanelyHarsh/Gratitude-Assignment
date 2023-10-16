//
//  SharePreviewView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 16/10/23.
//

import SwiftUI

struct SharePreviewView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isCopied:Bool = false
    @StateObject var sharePreviewVM:SharePreviewViewModel = SharePreviewViewModel()
    
    private var shareImage:UIImage? //Image("card-test-image")
    private let sharePrefix:String //"Life is short, but it is wide. This too shall pass."
    private let primaryCTAText:String
    
    public init(shareImage: UIImage?, sharePrefix: String,primaryCTAText:String) {
        self.shareImage = shareImage
        self.sharePrefix = sharePrefix
        self.primaryCTAText = primaryCTAText
    }
    var body: some View {
        ZStack(alignment:.top){
            VStack(){
                if let shareImage = shareImage{
                    Image(uiImage: shareImage)
                        .resizable()
                        .frame(width: 350, height: 350)
                        .cornerRadius(10)
                        .padding(1)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.gray)
                        }
                }
                else{
                    Image(systemName: "placeholder")
                        .resizable()
                        .frame(width: 350, height: 350)
                        .cornerRadius(10)
                        .padding(1)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.gray)
                        }
                }
                
                
                phrase
                
                
                Divider()
                    .padding(.horizontal)
                
                
                shareView
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .padding(.top,50)
            
            HStack{
                Text("Inspire your Friends")
                    .bold()
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .padding([.top])
        }.padding(.horizontal)
    }
    
    private var shareView:some View{
        VStack{
            Text("Share To")
                .bold()
                .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack(spacing: 30){
                
                Button {
                    self.sharePreviewVM.shareToWhatsApp()
                } label: {
                    shareOption("Whatsapp", "whatsapp-logo")
                }

                Button {
                    self.sharePreviewVM.shareToInstagram()
                } label: {
                    shareOption("Instagram", "insta-logo")
                }

                
                Button {
                    if let shareImage = shareImage{
                        _ = self.sharePreviewVM.saveImagetoGallery(shareImage)
                    }
                } label: {
                    shareOption("Download", systemImage: "square.and.arrow.down")
                }.disabled(shareImage == nil)
                
                
                ShareLink(item:  Image(uiImage: (shareImage ?? UIImage(named: "placeHolder"))!),
                          subject: Text(primaryCTAText),
                          message: Text(sharePrefix),
                          preview: SharePreview(
                            Text(primaryCTAText),
                            icon: Image("placeholder-image"))) {
                    shareOption("More",systemImage: "ellipsis")
                            }.disabled(shareImage == nil)
            }
            .font(.caption)
            .tint(.black)
            .frame(maxWidth: .infinity)
        }
    }
    
    var phrase:some View{
        HStack{
            //TODO: Add "..."
            Text(sharePrefix)
                .lineLimit(1)
            
            Button {
                UIPasteboard.general.string = sharePrefix
                withAnimation(.none){
                    isCopied = true
                }
            } label: {
                Text(isCopied ? "Copied" : "Copy")
            }
            .padding(7)
            .tint(isCopied ? .white : .pink)
            .background{
                Rectangle()
                    .cornerRadius(15)
                    .foregroundColor(.pink)
                    .opacity(isCopied ? 1.0 : 0.3)
            }
        }
        .padding()
        .background{
            Color.clipBoardBG.cornerRadius(30)
        }
    }
    
    
    @ViewBuilder
    private func shareOption(_ title:String, _ image:String)->some View{
        VStack{
            Image(image)
            Text(title)
        }
    }
    
    
    @ViewBuilder
    private func shareOption(_ title:String, systemImage image:String)->some View{
        VStack{
            Image(systemName: image)
                .frame(width: 15, height: 15)
                .padding()
                .background{
                    Circle().opacity(0.2)
                }
            Text(title)
        }
    }
}

struct SharePreviewView_Previews: PreviewProvider {
    static var previews: some View {
//        SharePreviewView()
        DailyZenCardView(cardContent: CardModel(uniqueID: "", title: "JSO",
                                                auther: "Rebecca Wells", text: "Life is short, but it is wide. This too shall pass.", articleURL: "",
                                                imageURL: "https://d3ez3n6m1z7158.cloudfront.net/exp/story_976.png",
                                                primayCTAText: "Add Affirmation",
                                                sharePrefix: "Here's a lovely affirmation from my Gratitude app 🌻 https://gratefulness.page.link/3T7N")
                                                )
    }
}
