//
//  TitleView.swift
//  2048
//
//  Created by cmStudent on 2021/12/02.
//

import SwiftUI
import Combine


struct TitleView: View {
    @StateObject var playViewModel =  PlayViewModel()
    // PlayViewに画面遷移する
    @State var isMovingPlayView = false
    // ScoreViewに画面遷移する
    @State var isMovingScoreView = false
    @State var highScore = 0
    @State var clear = 0
    @State var selection = 1
    @State var time = ""
    @State var times = 0
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                
                // タイトルロゴ
                //                Image("")
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                //                    .frame(maxWidth: 150, maxHeight: 150)
                
                // TODO: 画像に差し替える
                Text("2048")
                    .font(.largeTitle)
                
                Spacer()
                TextField("秒数を入力（デフォルト30秒/上から２桁）", text: Binding(
                    get: {playViewModel.time ?? "30"},
                    set: {playViewModel.time = $0.filter{"0123456789".contains($0)}}))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                .frame(width: UIScreen.main.bounds.width - 40)
                Spacer()
                
                // PlayViewに移動する
                Button {
                    isMovingPlayView.toggle()
                    guard playViewModel.text != nil else { return }
                    times = Int(playViewModel.text!) ?? 30
                    
                } label: {
                    ButtonView(buttonText: "START")
                }
                .padding()
                .fullScreenCover(isPresented: $isMovingPlayView){
                    PlayView(playViewModel: playViewModel, isMoving: $isMovingPlayView, score: playViewModel.score, highScore: $highScore, clear: $clear, time: $times)
                }
                
                // ScoreViewに移動する
                Button {
                    print("high\(highScore)")
                    isMovingScoreView.toggle()
                    print("high\(highScore)")
                    
                    
                } label: {
                    ButtonView(buttonText: "SCORE")
                }
                .fullScreenCover(isPresented: $isMovingScoreView){
                    ScoreView(playViewModel: playViewModel, isMoving: $isMovingScoreView, highScore: $highScore, clear: $clear)
                }
                
                
                Spacer()
            } //VStack
        } // ZStack
        .onAppear{
            clear = UserDefaults.standard.integer(forKey: "clear")
            highScore = UserDefaults.standard.integer(forKey: "Numeric")
            print("he\(highScore)")
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
