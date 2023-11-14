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
    @State private var tappedModel: Model = Model(modelName: "jar")
    @State private var isDetailViewActive: Bool = false
    @State private var audioPlayer: AVAudioPlayer!
    
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
                
                ARViewContainer(selectedModel: $selectedModel, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel, audioPlayer: $audioPlayer)
                    .edgesIgnoringSafeArea(.all)
                
                ModelPickerView(selectedModel: $selectedModel, models: models)
                
            }
            
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedModel: Model?
    @Binding var isDetailViewActive: Bool
    @Binding var tappedModel: Model
    @Binding var audioPlayer: AVAudioPlayer!
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel, audioPlayer: $audioPlayer)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = selectedModel {
            
            if let modelEntity = model.modelEntity {
                
                print("DEBUG: Adding model to scene - \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .horizontal) // Also .any
                anchorEntity.name = model.modelName
                anchorEntity.addChild(modelEntity)
                
                uiView.scene.addAnchor(anchorEntity)
                
                modelEntity.generateCollisionShapes(recursive: true)
                
                uiView.installGestures([.translation, .rotation, .scale], for: modelEntity)
                
                DispatchQueue.main.async {
                    playAudio()
                    selectedModel = nil
                }
                
                
                
            } else {
                print("DEBUG: Unable to load modelEntity for - \(model.modelName)")
            }
            
        }
        
    }
    
    func playAudio() {
        
        print("DEBUG: Playing audio")
        
        if let soundURL = Bundle.main.url(forResource: "add", withExtension: "mp3") {
            
            do {
                print("DEBUG: Effectively playing audio")
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer!.play()
            } catch {
                print("DEBUG: Unable to play audio")
            }
            
        }
        
    }
    
    
}




#Preview {
    ContentView()
}
