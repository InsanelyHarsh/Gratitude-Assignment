//
//  FailedView.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import SwiftUI

struct FailedView: View {
    var body: some View {
        VStack{
            Image(systemName: "figure.fishing")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
            
            Text("Something Went Wrong")
                .font(.title2)
                .bold()
            
            Button {
                
            } label: {
                Text("Try Again")
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
    }
}

struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        FailedView()
    }
}
