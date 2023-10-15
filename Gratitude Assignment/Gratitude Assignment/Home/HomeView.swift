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
            VStack{
                if(homeVM.isLoading){
                    ProgressView("Take a deep Breath")
                        .tint(.blue)
                }else{
                    ZStack(alignment:.top){
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 5) {
                                ForEach(homeVM.zenCards,id:\.uniqueID){ zenCard in
                                    DailyZenCardView(cardContent: zenCard)
                                    Divider()
                                }
                            }.padding(.top,5)
                        }
                        .offset(y: 100)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(0..<15){ i in
                                    Text("\(15+i)")
                                        .foregroundColor(i == 7 ? .white : .black)
                                        .padding()
                                        .background{
                                            Circle()
                                                .foregroundColor(i == 7 ? .pink : .black)
                                                .opacity(i == 7 ? 0.5 : 0.1)
                                        }
                                }
                            }
                        }
                        .frame(height: 100)
                    }
                }
            }
            .task{
                await self.homeVM.getDailyZenCard()
            }
            .navigationTitle("Gratitute")
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
