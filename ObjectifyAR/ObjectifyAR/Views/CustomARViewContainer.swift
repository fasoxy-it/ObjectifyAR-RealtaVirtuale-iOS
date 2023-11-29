//
//  CustomARViewContainer.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 14/11/23.
//

import SwiftUI

struct CustomARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var modelli: Modelli
    
    @Binding var selectedModel: Modello?
    @Binding var isDetailViewActive: Bool
    @Binding var tappedModel: Modello?
    
    func makeUIView(context: Context) -> CustomARView {
        
        return CustomARView(modelli: modelli, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
        if let model = selectedModel {
            print("DEBUG: Adding model to scene - \(model.name)")
            uiView.place3DModel(model: model)
            
            DispatchQueue.main.async {
                selectedModel = nil
            }
            
        }
        
    }
    
}
