//
//  FortuneView.swift
//  PunchTheClown
//
//  Created by David Klotz on 10/6/20.
//

import SwiftUI

struct FortuneView: View {
    
    public var showIntro: Bool
    @Binding var isPresented: ActiveSheet?
    
//    init(_ showIntro: Bool) {
//        self.showIntro = showIntro        
//    }
    var body: some View {
        if showIntro == true {
            Text("Every 20 punches Punch will tell you your fortune! After 100 punches you'll be able to get a fortune whenever you like!!")
                .padding(.leading, 50)
                .padding(.trailing, 50)
//                .onAppear { self.showWhatsNew = false }
        } else {
            let fortune = FortuneTeller.shared.getFortune()
            
            VStack {
                Spacer()
                Text(fortune.description)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    
                Spacer()
                Text("Was this fortune useful?")
                HStack {
                    Spacer()
                    Button(action: {
                        FortuneTeller.shared.fortuneHelpful(fortune: fortune, wasHelpful: true)
                        // Dismiss
                        self.isPresented = nil
                    
                    }) {
                        Text("Yes!")
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 50)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                    Spacer()
                    Button(action: {
                        FortuneTeller.shared.fortuneHelpful(fortune: fortune, wasHelpful: false)
                        //Dismiss
                        self.isPresented = nil
                        
                    }) {
                        Text("No...")
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 50)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                    
                    Spacer()
                }
            }
        }
    }
}

struct FortuneView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneView(showIntro: false, isPresented: .constant(.fortuneScreen))
    }
}
