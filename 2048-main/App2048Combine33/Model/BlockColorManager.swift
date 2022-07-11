//
//  BlockColorManager.swift
//  2048
//
//  Created by cmStudent on 2021/12/02.
//

import SwiftUI

// TODO: AssetsのBlockColorを修正する
/// ブロックの色を管理するModel
struct BlockColorManager {
    
    func BlockColor(number: Int) -> String {
        var color = ""
        
        switch number {
        
        case 2: color = "Num2"
        case 4: color = "Num4"
        case 8: color = "Num8"
        case 16: color = "Num16"
        case 32: color = "Num32"
        case 64: color = "Num64"
        case 128: color = "Num128"
        case 256: color = "Num256"
        case 512: color = "Num512"
        case 1024: color = "Num1024"
        case 2048: color = "Num2048"
        default: color = "DefaultBlock"
            
        }
        
        return color
    }
}
