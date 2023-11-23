//
//  ContentView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 29/10/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import AVKit

struct ContentView : View {
    
    @State private var selectedModel: Modello?
    @State private var tappedModel: String?
    @State private var isDetailViewActive: Bool = false
    
    var modelli: Modelli = Modelli()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                NavigationLink(destination: DetailView(model: $tappedModel.wrappedValue), isActive: $isDetailViewActive) {
                    EmptyView()
                }
                
                CustomARViewContainer(selectedModel: $selectedModel, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
                    .edgesIgnoringSafeArea(.all)
                
                ModelPickerView(modelli: modelli, selectedModel: $selectedModel)
                
            }
            
        }
        
    }
    
}
