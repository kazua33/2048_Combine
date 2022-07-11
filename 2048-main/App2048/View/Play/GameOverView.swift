//
//  GameOverView.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI

struct GameOverView: View {
    @StateObject var playViewModel = PlayViewModel()

    /// 画面遷移(TitleView)
    @Binding var isMoving: Bool
    /// 今回のスコア
    @Binding var score: Int
    
    @Binding var check: Int
    
    @Binding var playNumber: [[Int]]
    
    @Binding var highScore: Int
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                
                Text("GAME OVER…")
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Spacer()
                
                Text("SCORE")
                    .font(.title)
                    .padding()
                
                
                ScoreDisplay(score: $score)
                
                
                // TODO: 記録を更新した場合、「High Score!」と表示する
                Text(highScore < score ? "High Score!" : "")
                
                Spacer()
                
                // TitleViewに戻るボタン
                Button {
                    highScore = playViewModel.replay(highscore: highScore, Score: score)
                    highScore = UserDefaults.standard.integer(forKey: "Numeric")
                    print("he\(highScore)")
                    isMoving = false
                    print("he\(highScore)")
                } label: {
                    ButtonView(buttonText: "TITLE")
                }
                .padding()
                
                // 最初からやり直すボタン
                Button {
                    highScore = playViewModel.replay(highscore: highScore, Score: score)
                    highScore = UserDefaults.standard.integer(forKey: "Numeric")
                    check = playViewModel.check
                    score = playViewModel.score
                } label: {
                    ButtonView(buttonText: "REPLAY")
                }
                
                
                Spacer()
                
            } // VStack
        } // ZStack
    }
}
