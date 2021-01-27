//
//  SettingsView.swift
//  PunchTheClown
//
//  Created by David Klotz on 1/25/21.
//

import SwiftUI



struct SettingsView: View {
    
    @AppStorage("autoFortune") var autoFortune: Bool = true
    
    
    var body: some View {
        VStack {
            
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
            Spacer()
        }
        .padding()
        .background(Image("background2"))
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
