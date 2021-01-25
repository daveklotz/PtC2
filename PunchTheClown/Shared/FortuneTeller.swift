//
//  FortuneTeller.swift
//  PunchTheClown
//
//  Created by David Klotz on 10/19/20.
//

import SwiftUI

class FortuneTeller {
    
    static let shared = FortuneTeller()
    
    let fortuneStrings: Array<String>
    //@AppStorage("fortuneArray")
    var fortuneArray: Array<Fortune> = [Fortune]()
    
    private init() {
        let url = Bundle.main.url(forResource: "fortunes", withExtension: "plist")!
        let fortunesData = try! Data(contentsOf: url)
        self.fortuneStrings = try! PropertyListSerialization.propertyList(from: fortunesData, options: [], format: nil) as! [String]
        
        for index in 0..<self.fortuneStrings.count {
            self.fortuneArray.append(Fortune(id: index, fortuneString: self.fortuneStrings[index]))
        }
        
        NSLog(self.fortuneArray[1].description)
    }
    
    public func getFortune() -> Fortune {
        var fortune: Fortune
        
        let randomInt = Int.random(in: 1..<5458)
        fortune = self.fortuneArray[randomInt]
        
        return fortune
    }
    
    public func getHelpfulFortunes() -> [Fortune] {
        
        var helpfulFortunes: [Fortune] = [Fortune]()
        
        helpfulFortunes = self.fortuneArray.filter { $0.helpfulYes >= 1 }
        
        //helpfulFortunes = Array(self.fortuneArray[0..<100])
        
        return helpfulFortunes
    }
    
    public func fortuneHelpful(fortune: Fortune, wasHelpful: Bool) {
        if wasHelpful {
            self.fortuneArray[fortune.id].helpfulYes += 1
        } else {
            self.fortuneArray[fortune.id].helpfulNo += 1
        }
        
    }
}
