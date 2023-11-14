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
    
    @State private var selectedModel: Model?
    @State private var tappedModel: Model?
    @State private var isDetailViewActive: Bool = false
    
    private var models: [Model] = {
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {return []}
    
        var availableModels: [Model] = []
        
        for filename in files where filename.hasSuffix("usdz") {
            let  modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            availableModels.append(model)
        }
        
        return availableModels
        
    }()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                NavigationLink(destination: DetailView(model: $tappedModel.wrappedValue), isActive: $isDetailViewActive) {
                    EmptyView()
                }
                
                CustomARViewContainer(selectedModel: $selectedModel, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
                    .edgesIgnoringSafeArea(.all)
                
                ModelPickerView(selectedModel: $selectedModel, models: models)
                
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
