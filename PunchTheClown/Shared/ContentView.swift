//
//  ContentView.swift
//  Shared
//
//  Created by David Klotz on 6/30/20.
//

import SwiftUI
import AVFoundation
import GameKit

let timerInterval = 0.2

let theTimer =  Timer.publish(every: timerInterval, on: .main, in: .default).autoconnect()


struct ContentView: View {
    @State private var clownPosition:CGPoint = CGPoint(x: 0.0, y: 150.0)
    @State private var clownImage:String = "clown"
    
    @State var xMove:CGFloat = 50.0
    @State var yMove:CGFloat = 50.0
    @State var badCounter:Int = 0
    @State /*@AppStorage("oofCounter")*/ var oofCounter:Int = 0
    @AppStorage("totalPunches") var totalPunches:Int = 0
    @State @AppStorage("showWhatsNew") var showWhatsNew: Bool = false
    @State var bigTopSound: AVAudioPlayer?
    @State var punchSound: AVAudioPlayer?
    @State var groan1Sound: AVAudioPlayer?
    @State var groan2Sound: AVAudioPlayer?
    @State var groan3Sound: AVAudioPlayer?
    
    @State var presented: Bool = true
    @State var showingFortune: Bool = false
    
    //@EnvironmentObject var groan: AVAudioPlayer?
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("Game Score: \(oofCounter)")
                            .foregroundColor(.blue)
                        Spacer()
                        //                    .position(x: 50, y: 10)
                        Text("Total Score: \(totalPunches)")
                            .foregroundColor(.blue)
                        
                    }
                    Spacer()
                }
                
                
                
                VStack {
                    Image(clownImage)
                        .resizable()
                        .frame(width: 302, height: 450, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .onTapGesture {
                            self.clownImage = "punchedclown"
                            
                            let randoClownrissian = Int.random(in: 0..<3)
                            
                            var punchPath: String
                            if randoClownrissian == 0 {
                                punchPath = Bundle.main.path(forResource: "punch.wav", ofType:nil)!
                            } else if randoClownrissian == 1 {
                                punchPath = Bundle.main.path(forResource: "punch1.wav", ofType:nil)!
                            } else {
                                punchPath = Bundle.main.path(forResource: "punch2.wav", ofType:nil)!
                            }
                                                         
                            let url = URL(fileURLWithPath: punchPath)
                            
                            do {                                
                                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true)
                                
                                punchSound =  try AVAudioPlayer(contentsOf: url)
                                
                                punchSound?.play()
                                

                                if oofCounter % 3 == 0 {
                                    groan1Sound?.play()
                                } else if oofCounter % 3 == 1 {
                                    groan2Sound?.play()
                                } else {
                                    groan3Sound?.play()
                                }
                                oofCounter = oofCounter + 1
                                totalPunches = totalPunches + 1
                            } catch {
                                // couldn't load file :(
                            }
                            if oofCounter % 10 == 0 {
                                if oofCounter == 100 {
                                    self.showingFortune.toggle()
                                } else {
                                    self.showingFortune.toggle()
                                }
                            }
                            if oofCounter == 1 {
                                self.showWhatsNew.toggle()
                            }
                        }
                    
                    
                    
                }
                .position(clownPosition)
                .animation(.linear)
                .onReceive(theTimer) { (_) in
                    roam()
                    
                }
                .onAppear {
                    var punchPath = Bundle.main.path(forResource: "circus.wav", ofType:nil)!
                    var url = URL(fileURLWithPath: punchPath)
                    
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)
                        
                        bigTopSound =  try AVAudioPlayer(contentsOf: url)
                        bigTopSound?.numberOfLoops = -1
                        bigTopSound?.play()
                        
                        punchPath = Bundle.main.path(forResource: "groan1.m4a", ofType:nil)!
                        url = URL(fileURLWithPath: punchPath)
                        groan1Sound = try AVAudioPlayer(contentsOf: url)
                        
                        punchPath = Bundle.main.path(forResource: "groan2.m4a", ofType:nil)!
                        url = URL(fileURLWithPath: punchPath)
                        groan2Sound = try AVAudioPlayer(contentsOf: url)
                        
                        punchPath = Bundle.main.path(forResource: "groan3.m4a", ofType:nil)!
                        url = URL(fileURLWithPath: punchPath)
                        groan3Sound = try AVAudioPlayer(contentsOf: url)                                                
                        
                    } catch {
                        // couldn't load file :(
                    }
                }
            }
            .sheet(isPresented: $showingFortune, content: {
                FortuneView(showIntro: false, isPresented: $showingFortune, showWhatsNew: $showWhatsNew)
//                    .environmentObject($showWhatsNew)
            })
//            .sheet(isPresented: $showWhatsNew, content: {
//                FortuneView(showIntro: true, isPresented: $showWhatsNew)
//
//            })
            
        }
        .statusBar(hidden: true)
        
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
        //print(badCounter)
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
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            punchSound =  try AVAudioPlayer(contentsOf: url)
            //punchSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func playBigtop() -> Void {
        


        let punchPath = Bundle.main.path(forResource: "circus.wav", ofType:nil)!
        let url = URL(fileURLWithPath: punchPath)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
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
