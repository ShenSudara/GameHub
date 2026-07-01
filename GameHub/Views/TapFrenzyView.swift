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
        VStack{
            Text("Score: \(tapFrenzyVM.getScore())")
            
            TapButton(action: {
                tapFrenzyVM.incrementScore()
            })
        }
    }
}

#Preview {
    TapFrenzyView()
}
