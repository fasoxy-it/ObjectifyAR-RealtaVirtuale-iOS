//
//  CustomARViewContainer.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 14/11/23.
//

import SwiftUI

struct CustomARViewContainer: UIViewRepresentable {
    
    @Binding var selectedModel: Model?
    @Binding var isDetailViewActive: Bool
    @Binding var tappedModel: Model?
    
    func makeUIView(context: Context) -> CustomARView {
        
        return CustomARView(isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
        if let model = selectedModel {
            print("DEBUG: Adding model to scene - \(model.modelName)")
            uiView.place3DModel(model: model)
            
            DispatchQueue.main.async {
                selectedModel = nil
            }
            
            
        }
    }
    
}
