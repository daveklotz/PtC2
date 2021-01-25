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
        VStack {
            Spacer()
            Text(warning)
                .padding()
            Spacer()
            Text(judgement)
                .padding()
            Spacer()
            
        }// end Vstack
        .onAppear() {
            warning = PersonalityJudge.shared.provideWarning()
            judgement = PersonalityJudge.shared.provideJudgement()
        }
    }
    
    
    
}

struct PersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityView()
    }
}
