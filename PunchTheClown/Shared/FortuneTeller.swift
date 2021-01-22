//
//  FortuneTeller.swift
//  PunchTheClown
//
//  Created by David Klotz on 10/19/20.
//

import Foundation

class FortuneTeller {
    
    static let shared = FortuneTeller()
    
    let fortuneArray: Array<String>
    
    private init() {
        let url = Bundle.main.url(forResource: "fortunes", withExtension: "plist")!
        let fortunesData = try! Data(contentsOf: url)
        self.fortuneArray = try! PropertyListSerialization.propertyList(from: fortunesData, options: [], format: nil) as! [String]
        
        NSLog(self.fortuneArray[1])
    }
    
    public func getFortune() -> String {
        var fortune: String = "Don't take any wooden nickles"
        
        let randomInt = Int.random(in: 1..<5458)
        fortune = self.fortuneArray[randomInt]
        
        return fortune
    }
}
