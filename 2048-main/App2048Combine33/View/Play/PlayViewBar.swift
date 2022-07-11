//
//  PlayViewBar.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI
import Combine

struct PlayViewBar: View {
    @StateObject var playViewModel = PlayViewModel()
    /// 画面遷移(TitleView)
    @Binding var isMoving:Bool
    /// アラートの表示 (TitleViewに戻るか確認)
    @State private var showingAlert = false
    /// アラートの表示 (最初からやり直すか確認)
    @State private var showingResetAlert = false
    
    @State var isMovingPlayView = true
    
    @Binding var score: Int
    
    @Binding var check: Int
    
    @Binding var playNumber: [[Int]]
    
    @Binding var count: Int
    
    @Binding var time: Int
    
    var body: some View {
        // 画面上部 View分割したい
        HStack {
            
            // TitleViewに戻るボタン(アラート表示)
            Button {
                showingAlert.toggle()
            } label: {
                BarButtonView(buttonImage: "house")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("戻りますか?"),
                      message: Text("次回、スコアはリセットされます。"),
                      primaryButton:
                            .cancel(Text("No")),
                      secondaryButton:
                            .destructive(
                                Text("Yes"),
                                action: {
                                    isMoving = false
                                })
                )
            }
            
            Spacer()
            VStack {
                Text("2048")
                Text("\(count)")
            }
            
            Spacer()
            
            // 最初からやり直す(アラート表示)
            Button {
                showingResetAlert.toggle()
            } label: {
                BarButtonView(buttonImage: "arrow.triangle.2.circlepath.circle.fill")
            }
            .alert(isPresented: $showingResetAlert) {
                Alert(title: Text("最初からやり直しますか?"),
                      message: Text("スコアはリセットされます。"),
                      primaryButton:
                            .cancel(Text("No")),
                      secondaryButton:
                            .destructive(
                                Text("Yes"),
                                action: {
                                    // TODO: リセットする処理を書く

                                })
                )
            }
            
            
            
        } // HStac
        .onAppear{
            playViewModel.isTimerRunning = true
            count = time
            playViewModel.cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    count -= 1
                    if self.count <= 0 {
                        playViewModel.stopCounting()
                        check = 1
                    }
                }
            
        }
    }
}
