//
//  FrameView.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI

struct FrameView: View {
    
    @StateObject var playViewModel = PlayViewModel()
    
    @Binding var score: Int
    
    @Binding var check: Int
    
    @Binding var playNumber: [[Int]]
    
    @Binding var finish: Int
    var body: some View {
        ZStack {
            Color("FrameColor")
            
            VStack {
                ForEach(0..<playViewModel.playNumber.count) { tate in
                    HStack {
                        ForEach(0..<playViewModel.playNumber[0].count) { yoko in
                            BlockView(number: $playViewModel.playNumber[tate][yoko])
                        }
                    }
                } // ForEach
                
            } // VStack
        }// ZStack
        // スワイプ動作
        .gesture(DragGesture()
                 
                    .onEnded({ value in
            
            if value.translation.width < -75  {
                // 左スワイプする時の処理
                playViewModel.LeftSwipe()
                UserDefaults.standard.set(playViewModel.playNumber, forKey: "play")
                playViewModel.Clear()
                playViewModel.gameover()
                score = playViewModel.score
                check = playViewModel.check
                finish = playViewModel.finish
            } else if value.translation.width > 75{
                //右スワイプする時の処理
                playViewModel.RightSwipe()
                UserDefaults.standard.set(playViewModel.playNumber, forKey: "play")
                playViewModel.Clear()
                playViewModel.gameover()
                score = playViewModel.score
                check = playViewModel.check
                finish = playViewModel.finish
            } else if value.translation.height < -75 {
                // 上スワイプする時の処理
                playViewModel.UpSwipe()
                UserDefaults.standard.set(playViewModel.playNumber, forKey: "play")
                playViewModel.Clear()
                playViewModel.gameover()
                score = playViewModel.score
                check = playViewModel.check
                finish = playViewModel.finish
            } else if value.translation.height > 75{
                // 下スワイプする時の処理
                playViewModel.DownSwipe()
                UserDefaults.standard.set(playViewModel.playNumber, forKey: "play")
                playViewModel.Clear()
                playViewModel.gameover()
                score = playViewModel.score
                check = playViewModel.check
                finish = playViewModel.finish
            }
        })
        )
        .onAppear{
            
        }
    }
}


//struct FrameView_Previews: PreviewProvider {
//    @ObservedObject var playViewModel = PlayViewModel()
//    static var previews: some View {
//        FrameView(scoreNumber: playViewModel.score)
//    }
//}
