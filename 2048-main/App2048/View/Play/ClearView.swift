//
//  ClearView.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI

struct ClearView: View {
    @StateObject var playViewModel = PlayViewModel()
    /// 画面遷移(TitleView)
    @Binding var isMoving: Bool
    /// 今回のスコア
    @Binding var score: Int
    
    @Binding var check: Int
    
    @Binding var playNumber: [[Int]]
    @Binding var highScore: Int
    @Binding var clear: Int
    @Binding var isMovingClear: Bool
    var body: some View {
        ZStack {
            Color("BGColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Text("CLEAR!")
                    .font(.largeTitle)
                
                
                Text("SCORE")
                    .font(.title)
                    .padding()
                
                ScoreDisplay(score: $score)
                
                // TODO: 記録を更新した場合、「High Score!」と表示する
                Text(highScore < score ? "High Score!" : "")
                
               
                // TitleViewに戻るボタン
                Button {
                    if highScore < score {
                        highScore = score
                    }
                    clear += 1
                    UserDefaults.standard.set(clear, forKey: "clear")
                    clear = UserDefaults.standard.integer(forKey: "clear")
                    isMoving = false
                } label: {
                    ButtonView(buttonText: "TITLE")
                }
                .padding()
                
//                // 続けるボタン
//                Button {
//                    // TODO: 続ける処理を書く
//                    if highScore < score {
//                        highScore = score
//                    }
//                    isMovingClear = false
//                    UserDefaults.standard.set(clear, forKey: "clear")
//                    clear = UserDefaults.standard.integer(forKey: "clear")
//
//                } label: {
//                    // TODO: テキスト変更
//                    ButtonView(buttonText: "続ける")
//                }
                
                
            } // VStack
        } // ZStack
    }
}
