//
//  ClownSoundPlayer.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/21/21.
//

import Foundation
import AVFoundation

class ClownSoundPlayer {
    
    static let shared = ClownSoundPlayer()
    
    private var bigTopSound: AVAudioPlayer?
    
    private var tempSound: AVAudioPlayer?
    private var punchSounds: [AVAudioPlayer?] = [AVAudioPlayer?]()
        
    private var groanSounds: [AVAudioPlayer?] = [AVAudioPlayer?]()
    private static var groanCount: Int = 0
    
    private var fortuneAppearsSound: AVAudioPlayer?
    
    private init() {
        
        // MARK: - Load Punch Sounds
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            // AVAudioSession Issue...something is badly wrong
        }
        var soundPath = Bundle.main.path(forResource: "punch.wav", ofType:nil)!
        var soundURL = URL(fileURLWithPath: soundPath)
        do {
            tempSound =  try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            // cant open sound
        }
        punchSounds.append(tempSound)
        
        soundPath = Bundle.main.path(forResource: "punch1.wav", ofType:nil)!
        soundURL = URL(fileURLWithPath: soundPath)
        do {
            tempSound =  try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            // cant open sound
        }
        punchSounds.append(tempSound)
        
        soundPath = Bundle.main.path(forResource: "punch2.wav", ofType:nil)!
        soundURL = URL(fileURLWithPath: soundPath)
        do {
            tempSound =  try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            // cant open sound
        }
        punchSounds.append(tempSound)
        
        // MARK: - Load other sounds
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            var punchPath = Bundle.main.path(forResource: "circus.wav", ofType:nil)!
            var url = URL(fileURLWithPath: punchPath)
            bigTopSound =  try AVAudioPlayer(contentsOf: url)
            bigTopSound?.numberOfLoops = -1
            
            
            punchPath = Bundle.main.path(forResource: "groan1.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            tempSound = try AVAudioPlayer(contentsOf: url)
            self.groanSounds.append(tempSound)
            
            punchPath = Bundle.main.path(forResource: "groan2.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            tempSound = try AVAudioPlayer(contentsOf: url)
            self.groanSounds.append(tempSound)
            
            punchPath = Bundle.main.path(forResource: "groan3.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            tempSound = try AVAudioPlayer(contentsOf: url)
            self.groanSounds.append(tempSound)
            
            punchPath = Bundle.main.path(forResource: "chimes.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            fortuneAppearsSound = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            // couldn't load file :(
        }
    }
    
    func playBigtopSound()  {
        bigTopSound?.play()
    }
    
    func stopBigtopSound()  {
        bigTopSound?.stop()
    }
    
    func playPunchSound()  {
        let randoClownrissian = Int.random(in: 0..<3)
        self.punchSounds[randoClownrissian]?.play()
    }
    
    func playGroanSound()  {
        let g = ClownSoundPlayer.groanCount % 3
        self.groanSounds[g]?.play()
        ClownSoundPlayer.groanCount += 1
    }
    
    func playfortuneAppearsSound()  {
        fortuneAppearsSound?.play()
    }
    
    func stopfortuneAppearsSound()  {
        fortuneAppearsSound?.stop()
    }
}
