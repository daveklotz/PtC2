//
//  PersonalityView.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import SwiftUI

struct PersonalityView: View {
    
    @State var judgement: String = ""
    @State var warning: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("clownshrink")
                    .resizable()
                    .scaledToFit()
                    //.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .bottom)
                    .opacity(0.4)
                Spacer()
            }
            VStack {
                Spacer()
                Text(warning)
                    .font(.headline)
                    .padding()
                   .background(Color(.blue).opacity(0.5))
                    .cornerRadius(20.0)
                Spacer()
                Text(judgement)
                    .font(.headline)
                    .padding()
                    .background(Color(.red).opacity(0.5))
                     .cornerRadius(20.0)
                Spacer()
                
            }// end Vstack
            .onAppear() {
                warning = PersonalityJudge.shared.provideWarning()
                judgement = PersonalityJudge.shared.provideJudgement()
            }
        } // end Zstack
    }
    
    
    
}

struct PersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityView()
    }
}
