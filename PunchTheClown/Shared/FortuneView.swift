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
        if self.showIntro == true {
            Text("Every 100 punches Punch will tell you your fortune! After 1000 punches you'll be able to get a fortune whenever you like!!")
        } else {
            VStack {
                Spacer()
                Text("Don't take any wooden nickles")
                Spacer()
                Text("Was this fortune useful?")
                HStack {
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
