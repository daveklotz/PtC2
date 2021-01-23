//
//  FortuneModel.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/22/21.
//

import Foundation

struct Fortune: Identifiable, Codable, CustomStringConvertible {
    var id: Int
    var fortuneString: String
    var helpfulYes: Int
    var helpfulNo: Int
    
    init(id: Int, fortuneString: String, helpfulYes: Int = 0, helpfulNo: Int  = 0) {
        self.id = id
        self.fortuneString = fortuneString
        self.helpfulYes = helpfulYes
        self.helpfulNo = helpfulNo
    }
    
    public var description: String {
        return fortuneString
    }
    
}
