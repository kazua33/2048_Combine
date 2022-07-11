//
//  BarButtonView.swift
//  2048
//
//  Created by cmStudent on 2021/12/04.
//

import SwiftUI

/// バーに表示するボタンのレイアウト
struct BarButtonView: View {
    /// ボタンの画像
    let buttonImage: String
    
    var body: some View {
        Image(systemName: buttonImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .frame(width:35)
    }
}
