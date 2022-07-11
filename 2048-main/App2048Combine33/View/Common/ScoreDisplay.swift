//
//  SocreDisplay.swift
//  App2048
//
//  Created by cmStudent on 2021/12/06.
//

import SwiftUI

struct ScoreDisplay: View {
    @Binding var score: Int
    var body: some View {
        
        HStack {
            Spacer()
            Text(String(score))
            Spacer()
            Text("Pt")
        }.frame(width: 120, height: 60)
        
    }
}
