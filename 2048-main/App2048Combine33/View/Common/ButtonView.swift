//
//  ButtonView.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI

/// 全画面共通のボタンレイアウト
struct ButtonView: View {
    /// ボタンのテキスト
    let buttonText: String
    
    var body: some View {
        Text(buttonText)
            .font(.title)
            .frame(width: 190, height: 60)
            .background(Color("StartButton"))
            .cornerRadius(40)
            .foregroundColor(.white)
        
    }
}
