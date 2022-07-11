//
//  ScoreView.swift
//  2048
//
//  Created by cmStudent on 2021/12/02.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var playViewModel: PlayViewModel
    @Binding var isMoving: Bool
    @Binding var highScore: Int
    @Binding var clear: Int
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                
                HStack {
                    Button {
                        isMoving.toggle()
                    } label: {
                        BarButtonView(buttonImage: "house")
                    }
                    
                    Spacer()
                    
                    Text("2048")
                        .padding(.leading, -35)
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                Text("SCORE")
                    .font(.largeTitle)
                    .padding()
                
            
                
                Text("High Score")
                
                ScoreDisplay(score: $highScore)
                
                
                Text("クリア回数")
                Text("\(clear)回")
                
                Spacer()
            }
        } // ZStack
    }
}
