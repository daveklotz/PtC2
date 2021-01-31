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
            ZStack {
                VStack {
                    Image("clowngenie")
                        .resizable()
                        .scaledToFill()
                        
                        //.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .bottom)
                        .opacity(0.4)
                    Spacer()
                }
                VStack {
                Text("Every 20 punches Punch will tell you your fortune! After 100 punches you'll be able to get a fortune whenever you like!!")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
//                        .fixedSize()
                    .minimumScaleFactor(0.01)
                    .padding()
//                Spacer()
                Text("Rate enough fortunes as helpful and Punch will be able to give you deep insights into your personality!")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
//                        .fixedSize()
                    .minimumScaleFactor(0.01)
                    .padding()
                    
                    Button(action: {
                        
                        self.isPresented = nil
                    
                    }) {
                        Text("Dismiss")
                    }
                    .buttonStyle(ClownButtonStyle())
                }
                
                
                
            }
//                .onAppear { self.showWhatsNew = false }
        } else {
            let fortune = FortuneTeller.shared.getFortune()
            
            ZStack {
                VStack {
                    Image("clowngenie")
                        .resizable()
                        .scaledToFill()
                        
                        //.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .bottom)
                        .opacity(0.4)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text(fortune.description)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
//                        .fixedSize()
                        .minimumScaleFactor(0.01)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                        .frame(width: 100, height: 100, alignment: .center)
                        
                        
                        
                        
                    Spacer()
                    Text("Was this fortune useful?")
                        .padding()
                        .font(.title)
                        
                    HStack {
                        Spacer()
                        Button(action: {
                            FortuneTeller.shared.fortuneHelpful(fortune: fortune, wasHelpful: true)
                            // Dismiss
                            self.isPresented = nil
                        
                        }) {
                            Text("Yes!")
                        }
//                        .padding()
//                        .padding()
//                        .transition(.move(edge: .trailing))
//                        .animation(.default)
                        .buttonStyle(ClownButtonStyle())
                        Spacer()
                        Button(action: {
                            FortuneTeller.shared.fortuneHelpful(fortune: fortune, wasHelpful: false)
                            //Dismiss
                            self.isPresented = nil
                            
                        }) {
                            Text("No...")
                        }
//                        .padding(.bottom, 50)
//                        .padding(.top, 50)
//                        .transition(.move(edge: .trailing))
//                        .animation(.default)
                        .buttonStyle(ClownButtonStyle())
                        Spacer()
                    }
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
