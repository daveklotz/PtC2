//
//  SettingsView.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import SwiftUI



struct SettingsView: View {
    
    @AppStorage("autoFortune") var autoFortune: Bool = true
    @State private var showAlert = false
    @Binding var isPresented: ActiveSheet?
    
    
    var body: some View {
        NavigationView {
            
            List {
            Toggle(isOn: $autoFortune) {
                if autoFortune {
                    Text("Show fortune every 20 punches: ON".uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                } else {
                    Text("Show fortune every 20 punches: OFF".uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(Color.secondary)
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.red))
            .padding()
            .background(
                Color(red: 0.9, green: 0.9, blue: 0, opacity: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            )
//                Button(action: {
//                    // reset fortune dasta
//                    self.showAlert = true
//                    
//                }) {
//                    Text("Reset Fortune Helpfulness Data")
//                }
//                .alert(isPresented: $showAlert) { () -> Alert in
//                            let primaryButton = Alert.Button.default(Text("NO! Don't erase!")) {
//                                self.showAlert = false
//                                
//                            }
//                            let secondaryButton = Alert.Button.cancel(Text("Yes! Get rid of it!")) {
//                               deleteFortuneHelpfulnessData()
//                                self.showAlert = false
//                            }
//                            return Alert(title: Text("Erase Fortunes??"), message: Text("Clicking Yes will remove all the fortune input you worked so hard on! Are you sure???"), primaryButton: primaryButton, secondaryButton: secondaryButton)
//                        }
                NavigationLink(destination: LicensesView()) {
                  Text("Licenses")
                }
                NavigationLink(destination: PrivacyPolicyView()) {
                  Text("Privacy")
                }
                Button(action: {
                    
                    self.isPresented = nil
                
                }) {
                    HStack {
                        Spacer()
                        Text("Dismiss")
                        Spacer()
                    }
                }
            }
//            Spacer()
                
//                .background(Color.red)
            Spacer()
            
        } // edn NAVIGATIONVIEW
        .padding()
        //        .background(Image("background2"))
        .background(Color.yellow)
        
    }
    
    func deleteFortuneHelpfulnessData() {
        // just get rid of file.
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(.settingsScreen))
            
    }
}
