//
//  FortuneView.swift
//  PunchTheClown
//
//  Created by David Klotz on 10/6/20.
//

import SwiftUI

struct FortuneView: View {
    
    public var showIntro: Bool
    @Binding var isPresented: Bool
    
//    init(_ showIntro: Bool) {
//        self.showIntro = showIntro        
//    }
    var body: some View {
        if showIntro == true {
            Text("Every 100 punches Punch will tell you your fortune! After 1000 punches you'll be able to get a fortune whenever you like!!")
//                .onAppear { self.showWhatsNew = false }
        } else {
            let fortune = FortuneTeller.shared.getFortune()
            
            VStack {
                Spacer()
                Text(fortune)
                Spacer()
                Text("Was this fortune useful?")
                HStack {
                    Spacer()
                    Button(action: {
                        // Dismiss
                        self.isPresented = false
                    
                    }) {
                        Text("Yes!")
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 50)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                    Spacer()
                    Button(action: {
                        //Dismiss
                        self.isPresented = false
                        
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
        FortuneView(showIntro: false, isPresented: .constant(false))
    }
}
