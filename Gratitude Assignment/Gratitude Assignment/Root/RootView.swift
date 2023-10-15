//
//  RootView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootVM:RootViewModel = RootViewModel()
    var body: some View {
        ZStack{
            if(rootVM.isNetworkConnectionAvailable){
                HomeView()
            }else{
                VStack{
                    Image(systemName: "wifi.exclamationmark")
                        .tint(.pink)
                    
                    Text("Offline!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                    
                    HStack{
                        Button {
                            self.rootVM.checkConnection()
                        } label: {
                            Text("Try Again!")
                        }.buttonStyle(.borderedProminent)
                        
                        Button {
                            //TODO: Present data from core-data
                        } label: {
                            Text("Go Offline")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                    }
                }
            }
        }.onAppear{
//            self.rootVM.checkConnection()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
