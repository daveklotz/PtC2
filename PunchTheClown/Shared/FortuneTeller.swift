//
//  FortuneTeller.swift
//  PunchTheClown
//
//  Created by David Klotz on 10/19/20.
//

import Foundation

class FortuneTeller {
    
    static let shared = FortuneTeller()
    
    let fortuneStrings: Array<String>
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
    
    public func getFortune() -> String {
        var fortune: String = "Don't take any wooden nickles"
        
        let randomInt = Int.random(in: 1..<5458)
        fortune = self.fortuneArray[randomInt].description
        
        return fortune
    }
}
