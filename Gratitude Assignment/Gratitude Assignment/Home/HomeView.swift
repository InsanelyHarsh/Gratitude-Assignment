//
//  HomeView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            ZStack{
                Color.homeBG //Background Color
                
                if(homeVM.isLoading){
                    ProgressView("Take a deep Breath")
                        .tint(.blue)
                }else{
                    //Cards
                    ZStack(alignment:.top){
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 20) {
                                ForEach(homeVM.zenCards,id:\.uniqueID){ zenCard in
                                    DailyZenCardView(cardContent: zenCard)
                                }
                            }.padding(.top,5)
                        }
                        .offset(y: 100)
                        
                        //Horizontal Calendar
                        horizontalCalendar
                    }
                }
            }
            .alert(homeVM.alert.title, isPresented: $homeVM.showAlert, actions: {

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
    
    private var horizontalCalendar:some View{
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
                                Circle()
                                    .opacity(0.1)
                                    .foregroundColor(homeVM.currentDate.formatted(date: .numeric, time: .omitted) == date.formatted(date: .numeric, time: .omitted) ? .pink : .black) //TODO: improve
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
