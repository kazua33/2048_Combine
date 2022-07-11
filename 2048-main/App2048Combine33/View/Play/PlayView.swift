//
//  PlayView.swift
//  2048
//
//  Created by cmStudent on 2021/12/02.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var playViewModel: PlayViewModel
    /// 画面遷移(TitleView)
    @Binding var isMoving: Bool
    
    @State var score: Int
    
    @State var check = 0
    
    @State var playNumber = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]]
    
    @Binding var highScore: Int
    
    @Binding var clear: Int
    
    @State var isMovingClear = false
    
    @State var finish = 0
    
    @State var count = 0
    
    @Binding var time: Int
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .edgesIgnoringSafeArea(.all)
            
            if check == 0 {
                VStack {
                    
                    // 画面上部
                    PlayViewBar(isMoving: $isMoving, score: $score, check: $check, playNumber: $playNumber, count: $count, time: $time)
                        .padding()
                    
                    // 現在のスコア
                    Text("SCORE")
                    
                    Text("\(score)Pt")
                    
                    Spacer()
                    
                    // ゲーム
                    FrameView(score: $score, check: $check, playNumber: $playNumber, finish: $finish)
                    // TODO: 大きさ変更
                        .frame(width: 280, height: 280, alignment: .center)
                    
                    if finish == 1 {
                        Button {
                            check = 1
                        } label: {
                            ButtonView(buttonText: "Finish")
                        }
                        .padding()
                    } else {
                        Text("Finish")
                            .font(.title)
                            .frame(width: 190, height: 60)
                            .background(Color("BGColor"))
                            .cornerRadius(40)
                            .foregroundColor(Color("BGColor"))
                            .padding()
                    }
                    Spacer()
                } // VStack
            }
            
            if check == 1 {
                ClearView(isMoving: $isMoving, score: $score, check: $check, playNumber: $playNumber, highScore: $highScore, clear: $clear, isMovingClear: $isMovingClear)
            }
            // ゲームオーバーしたら表示
            if check == 2 {
                GameOverView(isMoving: $isMoving, score: $score, check: $check, playNumber: $playNumber, highScore: $highScore)
            }
        }
        .onAppear{
            count = playViewModel.count
        }
    }
        
    
}

