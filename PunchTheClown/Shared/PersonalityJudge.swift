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
    
    public func provideJudgement() -> String {
        
        var helpfulFortunes: [Fortune] = FortuneTeller.shared.getHelpfulFortunes()
        var document: String = String()
        
        for fortune in helpfulFortunes {
            document.append(fortune.fortuneString)
            document.append("\n")
            
        }
        
//        if let sentimentPredictor = try? NLModel(mlModel: EXT().model),
//            let result = sentimentPredictor.predictedLabel(for: document) {
//        }
//        
//        if let sentimentPredictor = try? NLModel(mlModel: NEU().model),
//            let result = sentimentPredictor.predictedLabel(for: document) {
//        }
//        
//        if let sentimentPredictor = try? NLModel(mlModel: AGR().model),
//            let result = sentimentPredictor.predictedLabel(for: document) {
//        }
//        
//        if let sentimentPredictor = try? NLModel(mlModel: CON().model),
//            let result = sentimentPredictor.predictedLabel(for: document) {
//        }
//        
//        if let sentimentPredictor = try? NLModel(mlModel: OPN().model),
//            let result = sentimentPredictor.predictedLabel(for: document) {
//        }
//        
        return "You suck."
    }
}
