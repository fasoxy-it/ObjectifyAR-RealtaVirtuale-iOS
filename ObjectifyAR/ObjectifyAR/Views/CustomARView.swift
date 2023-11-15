//
//  CustomARView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 09/11/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {
    
    @Binding var isDetailViewActive: Bool
    @Binding var tappedModel: Model?
    
    var focusEntity: FocusEntity?
    var audioPlayer: AVAudioPlayer?
    
    init(isDetailViewActive: Binding<Bool>, tappedModel: Binding<Model?>) {
        
        self._isDetailViewActive = isDetailViewActive
        self._tappedModel = tappedModel
        
        super.init(frame: .zero)
        
        self.setUpFocusEntity()
        self.setUpARView()
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func setUpFocusEntity() {
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
    }
    
    func setUpARView() {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            configuration.sceneReconstruction = .meshWithClassification
        }
        
        self.environment.sceneUnderstanding.options.insert(.occlusion)
        
        self.session.run(configuration)
        
        self.enableObjectRemoval()
        self.enableTap()
        self.enableScale()
        
    }
    
    func place3DModel(model: Model) {
        
        guard let focusEntity = self.focusEntity else {return}
        
        let modelEntity = try! ModelEntity.loadModel(named: model.modelName + ".usdz")
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        anchorEntity.name = model.modelName
        anchorEntity.addChild(modelEntity)
        self.scene.addAnchor(anchorEntity)
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        //self.installGestures([.all], for: modelEntity as HasCollision)
        
        DispatchQueue.main.async {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            self.playAudio(action: "add")
        }
        
    }
    
    func playAudio(action: String) {
        
        print("DEBUG: Playing audio")
        
        if let soundURL = Bundle.main.url(forResource: action, withExtension: "mp3") {
            
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

extension CustomARView {
    
    func enableScale() {
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        self.addGestureRecognizer(pinchGestureRecognizer)
        
    }
    
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        
        let location = recognizer.location(in: self)
        
        if recognizer.state == .changed {
                
                if let entity = self.entity(at: location) {
                    
                    if let anchorEntity = entity.anchor {
                        
                        let pinchScaleX = Float(recognizer.scale) * anchorEntity.scale.x
                        let pinchScaleY = Float(recognizer.scale) * anchorEntity.scale.y
                        let pinchScaleZ = Float(recognizer.scale) * anchorEntity.scale.z
                        
                        print("DEBUG: \(pinchScaleX), \(pinchScaleY), \(pinchScaleZ)")
                        
                        anchorEntity.scale = SIMD3(pinchScaleX, pinchScaleY, pinchScaleZ)
                        recognizer.scale = 1
                        
                    }
                    
                }
                
        }
    }
    
    
    func enableObjectRemoval() {
            
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) {
            
            if let anchorEntity = entity.anchor {
                DispatchQueue.main.async { [self] in
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    anchorEntity.removeFromParent()
                    playAudio(action: "remove")
                    print("DEBUG: Removed anchor with name: \(anchorEntity.name)")
                }
            }
            
        }
        
    }
    
    func enableTap() {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
            self.addGestureRecognizer(tapGesture)
        }
        
        @objc func handleTap(recognizer: UIGestureRecognizer) {
            
            let location = recognizer.location(in: self)
            
            if let entity = self.entity(at: location) {
                
                if let anchorEntity = entity.anchor {
                    
                    DispatchQueue.main.async { [self] in
                        
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        print("DEBUG: Tapped anchor with name: \(anchorEntity.name)")
                        playAudio(action: "add")
                        tappedModel = Model(modelName: anchorEntity.name)
                        isDetailViewActive = true
                        
                    }
                    
                }
                
            }
        }
    
}
