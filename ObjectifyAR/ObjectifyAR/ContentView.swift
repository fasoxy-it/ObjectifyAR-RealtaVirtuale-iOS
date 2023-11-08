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
        
        ZStack(alignment: .bottom) {
            ARViewContainer(selectedModel: $selectedModel)
                .edgesIgnoringSafeArea(.all)
            
            ModelPickerView(selectedModel: $selectedModel, models: models)
            
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedModel: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
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
                
            } else {
                print("DEBUG: Unable to load modelEntity for - \(model.modelName)")
            }
            
            
        }
        
    }
    
}

class CustomARView: ARView {
    
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect) {
        
        super.init(frame: frameRect)
        
        focusSquare.viewDelegate = self
        focusSquare.delegate =  self
        focusSquare.setAutoUpdate(to: true)
        
        self.setupARView()
        
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupARView() {
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
        
        self.enableObjectRemoval()
        self.enableTap()
        
    }
    
}

extension CustomARView {
    
    func enableObjectRemoval() {
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) {
            
            if let anchorEntity = entity.anchor {
                anchorEntity.removeFromParent()
                print("DEBUG: Removed anchor with name: \(anchorEntity.name)")
            }
            
        }
        
    }
    
    func enableTap() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(recognizer: UIGestureRecognizer) {
        
        print("DEBUG: Apparently works!")
        
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) {
            
            if let anchorEntity = entity.anchor {
                print("DEBUG: Tapped anchor with name: \(anchorEntity.name)")
                
            }
            
        }
    }
    
}

extension CustomARView: FEDelegate {
    
    func toTrackingState() {
        print("tracking")
    }
    
    func toInitializingState() {
        print("initializing")
    }
    
}

struct ModelPickerView: View {
    
    @Binding var selectedModel: Model?
    
    var models: [Model]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count) { index in
                    Button(action: {
                        print("DEBUG: Selected model with name: \(models[index].modelName)")
                        selectedModel = models[index]
                    }) {
                        VStack {
                            Image(uiImage: models[index].image)
                                .resizable()
                                .frame(height: 80)
                                .aspectRatio(1/1, contentMode: .fit)
                                .background(Color.white)
                                .cornerRadius(12)
                            Text(models[index].modelName)
                        }
                        
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
