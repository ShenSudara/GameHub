//
//  TapFrenzyView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import SwiftUI

// game main view
struct TapFrenzyView: View {
    // view model for tap frenzy
    @StateObject var tapFrenzyVM: TapFrenzyViewModel = TapFrenzyViewModel()
    
    var body: some View {
        VStack(spacing: 30){
            // score card
            HStack {
                ScoreCard(title: "Score", value: tapFrenzyVM.getScore())
            }.padding(.horizontal)
            
            // inner container
            VStack{
                TapButton(action: {
                    tapFrenzyVM.incrementScore()
                })
                .transition(.scale.combined(with: .opacity))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // other buttons
        }
    }
}

#Preview {
    TapFrenzyView()
}
