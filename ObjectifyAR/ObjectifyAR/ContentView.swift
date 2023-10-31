//
//  ContentView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 29/10/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    @State private var selectedModel: String?
    
    private var models: [String] = {
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {return []}
    
        var availableModels: [String] = []
        
        for filename in files where filename.hasSuffix("usdz") {
            let  modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            availableModels.append(modelName)
        }
        
        return availableModels
        
    }()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ARViewContainer(selectedModel: $selectedModel)
                .edgesIgnoringSafeArea(.all)
            
            ModelPickerView(selectedModel: $selectedModel, models: models)
            
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedModel: String?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let modelName = selectedModel {
            let modelEntity = try! ModelEntity.loadModel(named: modelName)
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity)
            uiView.scene.addAnchor(anchorEntity)
            
            modelEntity.generateCollisionShapes(recursive: true)
            
            uiView.installGestures([.translation, .rotation, .scale], for: modelEntity)
        }
        
    }
    
}

struct ModelPickerView: View {
    
    @Binding var selectedModel: String?
    
    var models: [String]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count) { index in
                    Button(action: {
                        print("DEBUG: Selected model with name: \(models[index])")
                        selectedModel = models[index]
                    }) {
                        Image(uiImage: UIImage(named: models[index])!)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
        
    }
    
}

#Preview {
    ContentView()
}
