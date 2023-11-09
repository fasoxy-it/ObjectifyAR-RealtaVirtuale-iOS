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

struct ContentView : View {
    
    @State private var selectedModel: Model?
    @State private var tappedModel: String = "jar"
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
                
                ARViewContainer(selectedModel: $selectedModel, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
                    .edgesIgnoringSafeArea(.all)
                
                ModelPickerView(selectedModel: $selectedModel, models: models)
                
            }
            
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedModel: Model?
    @Binding var isDetailViewActive: Bool
    @Binding var tappedModel: String
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = selectedModel {
            
            if let modelEntity = model.modelEntity {
                
                print("DEBUG: Adding model to scene - \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.name = model.modelName
                anchorEntity.addChild(modelEntity)
                
                uiView.scene.addAnchor(anchorEntity)
                
                modelEntity.generateCollisionShapes(recursive: true)
                
                uiView.installGestures([.translation, .rotation, .scale], for: modelEntity)
                
                DispatchQueue.main.async {
                    selectedModel = nil
                }
                
            } else {
                print("DEBUG: Unable to load modelEntity for - \(model.modelName)")
            }
            
        }
        
    }
    
}




#Preview {
    ContentView()
}
