//
//  ContentView.swift
//  Shared
//
//  Created by David Klotz on 6/30/20.
//

import SwiftUI
import AVFoundation

let timerInterval = 0.2

let theTimer =  Timer.publish(every: timerInterval, on: .main, in: .default).autoconnect()


struct ContentView: View {
    @State private var clownPosition:CGPoint = CGPoint(x: 0.0, y: 150.0)
    @State private var clownImage:String = "clown"
    
    @State var xMove:CGFloat = 50.0
    @State var yMove:CGFloat = 50.0
    @State var badCounter:Int = 0
    
    var body: some View {
        VStack {
            Image(clownImage)
                .resizable()
                .frame(width: 302, height: 450, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .onTapGesture {
                    self.clownImage = "punchedclown"
                    //playPunch()
                    //playOh()
                }
                
                

        }
        .position(clownPosition)
        .animation(.linear)
        .onReceive(theTimer) { (_) in
            roam()
        }
    }
    
    func roam() -> Void {
        

        
        if self.clownPosition.x + 10 > UIScreen.main.bounds.width {
            self.xMove *= -1
        }
        
        if self.clownPosition.y + 10 > UIScreen.main.bounds.height {
            self.yMove *= -1
        }
        
        if self.clownPosition.x < 0 {
            self.xMove *= -1
        }
        
        if self.clownPosition.y < 0 {
            self.yMove *= -1
        }

        self.clownPosition.x = self.clownPosition.x + self.xMove
        self.clownPosition.y = self.clownPosition.y + self.yMove
        
        badCounter += 1
        print(badCounter)
        if badCounter > 4 {
            self.clownImage = "clown"
            badCounter = 0;
        }
        
    }
    
    func playPunch() -> Void {
        var punchSound: AVAudioPlayer?


        let punchPath = Bundle.main.path(forResource: "punch.wav", ofType:nil)!
        let url = URL(fileURLWithPath: punchPath)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            punchSound =  try AVAudioPlayer(contentsOf: url)
            punchSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
