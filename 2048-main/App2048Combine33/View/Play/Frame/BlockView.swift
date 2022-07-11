//
//  BlockView.swift
//  2048
//
//  Created by cmStudent on 2021/12/03.
//

import SwiftUI

struct BlockView: View {
    private let colorManager = BlockColorManager()
    /// ブロックの数字
    @Binding var number: Int

    var body: some View {
        
        // TODO: 大きさ変更
        Text(number == 0 ? "" : String(number))
            .frame(width: 60, height: 60, alignment: .center)
            .background(Color(colorManager.BlockColor(number: number)))
        
    }
}
