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
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
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
        
        let modelEntity = try! ModelEntity.loadModel(named: "jar")
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(modelEntity)
        uiView.scene.addAnchor(anchorEntity)
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        uiView.installGestures([.translation, .rotation, .scale], for: modelEntity)
        
    }
    
}

#Preview {
    ContentView()
}
