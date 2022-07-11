//
//  Animation.swift
//  2048
//
//  Created by cmStudent on 2021/12/05.
//

import Foundation
import SwiftUI

class AnimatuinManager{
    
//    @Binding private var start : CGFloat
//    @Binding private end
    
    func Animation(start:Int,end:Int) -> (CGFloat,CGFloat) {
        //アニメーションさせるためにint型の引数をCGFloat型にキャストしている
        var startFloat = CGFloat(start)
        var endFloat = CGFloat(end)
        
        return (startFloat,endFloat)
    }
}
