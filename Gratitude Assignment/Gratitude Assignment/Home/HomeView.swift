//
//  HomeView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import SwiftUI

/*
 * Share Functionalities (^)
 * Refactor UI (^)
 * Alerts (X)
 * Core Data Integration (-)
 
 - Loading Page Animation (^)
 - Disable, Enable Prev/Next Buttons (^)
 - Load Images Concurrently (^)
 - Cache Images, Default Image & Reload Image (^)
 
 ~ Network Availibility, Unit Tests (XX)
 */
struct HomeView: View {
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            ZStack{
                Color.homeBG
                
                if(homeVM.isLoading){
                    ProgressView("Take a deep Breath")
                        .tint(.blue)
                }else{
                    
                    ZStack(alignment:.top){
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 20) {
                                ForEach(homeVM.zenCards,id:\.uniqueID){ zenCard in
                                    DailyZenCardView(cardContent: zenCard)
                                }
                            }.padding(.top,5)
                        }
                        .offset(y: 100)
                        
                        ZStack{
                            ScrollViewReader { scrollProxy in
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(homeVM.datesArray,id:\.self){ date in
                                            VStack{
                                                Text(date.getDay)
                                                Text(date.getMonth)
                                            }
                                            .id(date.description)
                                            .padding()
                                            .background{
                                                Circle().opacity(0.1)
                                                    .foregroundColor(homeVM.currentDate.formatted(date: .numeric, time: .omitted) == date.formatted(date: .numeric, time: .omitted) ? .pink : .black)
                                            }
                                        }
                                    }
                                }
                                .frame(height: 100)
                                .onAppear{
                                    scrollProxy.scrollTo(homeVM.currentDate)
                                }
                            }
                        }
                    }
                }
            }
            .alert(homeVM.alert.title, isPresented: $homeVM.showAlert, actions: {
//                homeVM.alert.action()
            }, message: {
                Text(homeVM.alert.description)
            })
            .task{
                await self.homeVM.getDailyZenCard()
            }
            .navigationTitle(homeVM.currentDate.getDateDescription)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task{
                            await self.homeVM.getPrevDayCard()
                        }
                    } label: {
                        VStack{
                            Image(systemName: "chevron.left.circle")
                            Text("Prev")
                        }
                    }
                    .disabled(self.homeVM.isPrevButtonDisabled)
                    .tint(.pink)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task{
                            await self.homeVM.getNextDayCard()
                        }
                    } label: {
                        VStack{
                            Image(systemName: "chevron.right.circle")
                            Text("Next")
                        }
                    }
                    .disabled(self.homeVM.isNextButtonDisabled)
                    .tint(.pink)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
