//
//  ActiveSheet.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import Foundation

enum ActiveSheet: Identifiable {
    case fortuneScreen, personalityScreen, settingsScreen
    
    var id: Int {
        hashValue
    }
}

