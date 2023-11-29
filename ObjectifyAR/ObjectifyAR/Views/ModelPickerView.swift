//
//  ModelPickerView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 09/11/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ModelPickerView: View {
    
    @EnvironmentObject var modelli: Modelli // Altrimenti lo trasformo i un @ObservedObject ed elimino .environmentObject(modelli) dalla ContentView
    
    @Binding var selectedModel: Modello?
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(modelli.modelli) { modello in
                    Button(action: {
                        print("DEBUG: Selected model with name: \(modello.name)")
                        selectedModel = modello
                    }) {
                        
                        ModelPicker(model: modello)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
        }
        .padding()
        .background(LinearGradient(colors: [.lightGray.opacity(0.0), .lightGray.opacity(0.5)], startPoint: .top, endPoint: .bottom))
        
    }
    
    
    
}




