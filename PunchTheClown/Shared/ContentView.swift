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

struct BuyView: View {
  @Binding var purchased:Bool
  @ObservedObject var products = productsDB.shared
  var body: some View {
  List {
    ForEach((0 ..< self.products.items.count), id: \.self) { column in
      Text(self.products.items[column].localizedDescription)
        .onTapGesture {
          //purchaseV5(self.products.items[column])
      }
    }
  }
 }
}

struct ContentView: View {
    @State private var clownPosition:CGPoint = CGPoint(x: 0.0, y: 150.0)
    @State private var clownImage:String = "clown"
    
    @State var xMove:CGFloat = 50.0
    @State var yMove:CGFloat = 50.0
    @State var badCounter:Int = 0
    @State var oofCounter:Int = 0
    @AppStorage("totalPunches") var totalPunches:Int = 0
    @State var bigTopSound: AVAudioPlayer?
    @State var punchSound: AVAudioPlayer?
    @State var groanSounds:[AVAudioPlayer?]?
    
    @State var purchased:Bool = true
    @State var storePresented:Bool = false
    
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
                        Spacer()
                        //                    .position(x: 50, y: 10)
                        Text("Total Score: \(totalPunches)")
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
                            playPunch()
                        }
                }
                .position(clownPosition)
                .animation(.linear)
                .onReceive(theTimer) { (_) in
                    roam()
                }
                .onAppear {
                    setupAudioPlayer()
                    IAPManager.shared.getProductsV5()
                }
                
                
                
                
                Button(action: {
                    self.storePresented.toggle()
                }, label: {
                    Text("Store!")
                })
                .sheet(isPresented: self.$storePresented) {
                    BuyView(purchased: self.$purchased)
                }
                .foregroundColor(.red)
                
                //                    BuyView(purchased: self.$purchased)
                

            }
        }
        .statusBar(hidden: true)
        
    }
    
    
    func setupAudioPlayer() -> Void {
        var punchPath = Bundle.main.path(forResource: "circus.wav", ofType:nil)!
        var url = URL(fileURLWithPath: punchPath)
        var groan1Sound: AVAudioPlayer?
        var groan2Sound: AVAudioPlayer?
        var groan3Sound: AVAudioPlayer?
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            bigTopSound =  try AVAudioPlayer(contentsOf: url)
            bigTopSound?.numberOfLoops = -1
//            #if targetEnvironment(simulator)
            // do nothing
//            #else
            bigTopSound?.play()
//            #endif
            
            punchPath = Bundle.main.path(forResource: "groan1.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            groan1Sound = try AVAudioPlayer(contentsOf: url)
            
            punchPath = Bundle.main.path(forResource: "groan2.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            groan2Sound = try AVAudioPlayer(contentsOf: url)
            
            punchPath = Bundle.main.path(forResource: "groan3.m4a", ofType:nil)!
            url = URL(fileURLWithPath: punchPath)
            groan3Sound = try AVAudioPlayer(contentsOf: url)
            
            groanSounds = [groan1Sound, groan2Sound, groan3Sound]
            
        } catch {
            // couldn't load file :(
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
        //print(badCounter)
        if badCounter > 4 {
            self.clownImage = "clown"
            badCounter = 0;
        }
    }
    
    
    func playPunch() -> Void {
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
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            punchSound =  try AVAudioPlayer(contentsOf: url)
            #if targetEnvironment(simulator)
            // do nothing
            #else
            punchSound?.play()
            #endif
            
//            #if targetEnvironment(simulator)
            // do nothing
//            #else
            let groanNum = oofCounter % 3
            groanSounds?[groanNum]?.play()
//            #endif
            oofCounter = oofCounter + 1
            totalPunches = totalPunches + 1
        } catch {
            // couldn't load file :(
        }
    }
    
    
    func playBigtop() -> Void {
        let punchPath = Bundle.main.path(forResource: "circus.wav", ofType:nil)!
        let url = URL(fileURLWithPath: punchPath)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            punchSound =  try AVAudioPlayer(contentsOf: url)
            #if targetEnvironment(simulator)
            // do nothing
            #else
            punchSound?.play()
            #endif
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
