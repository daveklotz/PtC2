//
//  PersonalityJudge.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import Foundation
import NaturalLanguage

struct PersonalityJudge {
    
    static let shared = PersonalityJudge()
    var personalitiesStrings: [String] = [String]()
    
    private init() {
        let url = Bundle.main.url(forResource: "personalities", withExtension: "plist")!
        let personalityData = try! Data(contentsOf: url)
        self.personalitiesStrings = try! PropertyListSerialization.propertyList(from: personalityData, options: [], format: nil) as! [String]
    }
    
    public func provideWarning() -> String {
        let helpfulFortunes: [Fortune] = FortuneTeller.shared.getHelpfulFortunes()
        var warningString: String
        
        if helpfulFortunes.count > 0 {
            warningString = "This, of course, is purely for entertainment purposes. But since you're too cheap to go hire a shrink, here you go:"
        } else {
            warningString = "You really should rate more fortunes so I can get a better handle on your state of mind, I'll give it a shot. This, of course, is purely for entertainment purposes. But since you're too cheap to go hire a shrink, here you go:"
        }
        
        return warningString
    }
    
    public func provideJudgement() -> String {
        
        let helpfulFortunes: [Fortune] = FortuneTeller.shared.getHelpfulFortunes()        
        var document: String = String()
        
        for fortune in helpfulFortunes {
            document.append(fortune.fortuneString)
            document.append("\n")
            
        }
        
        var personalityEntry: Int = 0
        
        // most significant bit
        if let sentimentPredictor = try? NLModel(mlModel: EXT().model),
            let result = sentimentPredictor.predictedLabel(for: document) {
            
            if result == "y" {
                personalityEntry = 16
            }
        }
        
        if let sentimentPredictor = try? NLModel(mlModel: NEU().model),
            let result = sentimentPredictor.predictedLabel(for: document) {
            if result == "y" {
                personalityEntry = personalityEntry + 8
            }
        }
        
        if let sentimentPredictor = try? NLModel(mlModel: AGR().model),
            let result = sentimentPredictor.predictedLabel(for: document) {
            
            if result == "y" {
                personalityEntry = personalityEntry + 4
            }
        }
        
        if let sentimentPredictor = try? NLModel(mlModel: CON().model),
            let result = sentimentPredictor.predictedLabel(for: document) {
            
            if result == "y" {
                personalityEntry = personalityEntry + 2
            }
        }
        
        //least significant bit
        if let sentimentPredictor = try? NLModel(mlModel: OPN().model),
            let result = sentimentPredictor.predictedLabel(for: document) {
            
            if result == "y" {
                personalityEntry = personalityEntry + 8
            }
            
        }
        
        let finalString = self.personalitiesStrings[personalityEntry]
        return finalString
    }
}
