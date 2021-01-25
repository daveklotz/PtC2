//
//  PersonalityView.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import SwiftUI

struct PersonalityView: View {
    
    var judgement: String = PersonalityJudge.shared.provideJudgement()
    
    var body: some View {
        Text(judgement)
    }
}

struct PersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityView()
    }
}
