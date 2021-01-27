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
    @AppStorage("showWhatsNew") var showWhatsNew: Bool = true
    @AppStorage("autoFortune") var autoFortune: Bool = true
//    @State var bigTopSound: AVAudioPlayer?
//    @State var punchSound: AVAudioPlayer?
//    @State var groan1Sound: AVAudioPlayer?
//    @State var groan2Sound: AVAudioPlayer?
//    @State var groan3Sound: AVAudioPlayer?
//    @State var fortuneAppearsSound: AVAudioPlayer?
    
    @State var presented: Bool = true
    @State var showingFortune: Bool = false
    @State var showingPersonality: Bool = false
    @State var activeSheet: ActiveSheet?
    
    //@EnvironmentObject var groan: AVAudioPlayer?
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        VStack {
                            Text("Game Score: \(oofCounter)")
                                .foregroundColor(.yellow)
                                .font(.footnote)
                            Text("Total Score: \(totalPunches)")
                                .foregroundColor(.yellow)
                                .font(.footnote)
                        }
                        .padding()
                        Spacer()
                        //                    .position(x: 50, y: 10)
                        Button(action: {
                            self.pauseBigTopsSounds()
                            self.activeSheet = .settingsScreen
                            
                            
                        }) {
                            Image(systemName: "gearshape")
                                .accentColor(.yellow)
                                .padding()
                        }
                        
                    }
                    Spacer()
                    if self.totalPunches > 99 {
                        HStack {
                            Button(action: {
                                self.pauseBigTopsSounds()
//                                self.showingFortune.toggle()
                                self.activeSheet = .fortuneScreen
                                
                                
                            }) {
                                Text("Show Me A Fortune!!")
                            }
                            .padding()
                            Spacer()
                            Button(action: {
                                self.pauseBigTopsSounds()
//                                self.showingPersonality.toggle()
                                self.activeSheet = .personalityScreen
                                
                                
                            }) {
                                Text("My Personality")
                            }
                            .padding()
                        }
                    }
                }
                
                
                
                VStack {
                    Image(clownImage)
                        .resizable()
                        .frame(width: 302, height: 450, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .onTapGesture {
                            self.showWhatsNew = false ///REMOVE
                            
                            self.clownImage = "punchedclown"

                            ClownSoundPlayer.shared.playPunchSound()
                            ClownSoundPlayer.shared.playGroanSound()
                            
                            oofCounter = oofCounter + 1
                            totalPunches = totalPunches + 1
                            
                            if (oofCounter % 20 == 0) && autoFortune {
                                self.pauseBigTopsSounds()
                                self.activeSheet = .fortuneScreen
                                if totalPunches == 20 {
                                    self.showWhatsNew = true
                                }
//                                if oofCounter == 100 {
//                                    self.showingFortune.toggle()
//                                    self.activeSheet = .fortuneScreen
//                                } else {
//                                    self.showingFortune.toggle()
//                                    self.activeSheet = .personalityScreen
//                                }
                            }
                        }
                }
                .position(clownPosition)
                .animation(.linear)
                .onReceive(theTimer) { (_) in
                    roam()
                    
                }
                .onAppear {
                    //ClownSoundPlayer.shared.playBigtopSound()
                    
                }
            }
            
            
            .sheet(item: $activeSheet, onDismiss: {
                self.restartBigTop()
                self.activeSheet = nil
            }, content: { item in
                let intro: Bool = self.showWhatsNew
                
                if item == .fortuneScreen {
                    FortuneView(showIntro: intro, isPresented: $activeSheet)
                        .onAppear {
                            self.playFortuneSounds()
                        }
                } else if item == .personalityScreen {
                    PersonalityView()                    
                } else {
                    SettingsView()
                }
                
            })
//            .onAppear {
//                self.playFortuneSounds()
//            }
//            //            .sheet(isPresented: $showWhatsNew, content: {
//            //                FortuneView(showIntro: true, isPresented: $showWhatsNew)
//            //
//            //            })
//            .sheet(isPresented: $showingPersonality, onDismiss: {
//                self.restartBigTop()
//            }, content: {
//                PersonalityView()
//            }).onAppear {
//                self.playFortuneSounds()
//            }
            
        }
        .statusBar(hidden: true)
        
    }
    func playFortuneSounds() -> Void {
        // play sounds
    }
    
    func pauseBigTopsSounds() -> Void {
        ClownSoundPlayer.shared.stopBigtopSound()
        ClownSoundPlayer.shared.playfortuneAppearsSound()
    }
    
    func restartBigTop() -> Void {
        ClownSoundPlayer.shared.playBigtopSound()
        ClownSoundPlayer.shared.stopfortuneAppearsSound()
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
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
