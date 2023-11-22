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
    @Binding var tappedModel: String?
    
    var focusEntity: FocusEntity?
    var audioPlayer: AVAudioPlayer?
    
    init(isDetailViewActive: Binding<Bool>, tappedModel: Binding<String?>) {
        
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
        self.environment.sceneUnderstanding.options.insert(.receivesLighting)
        self.environment.sceneUnderstanding.options.insert(.collision)
        
        self.session.run(configuration)
        
    }
    
    func place3DModel(model: Modello) {
        
        guard let focusEntity = self.focusEntity else {return}
        
        let modelEntity = model.modelEntity
        //modelEntity.generateCollisionShapes(recursive: true)
        modelEntity.scale = [1.0, 1.0, 1.0]
        
        
        
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        anchorEntity.name = model.name
        //anchorEntity.scale = [1.0, 1.0, 1.0]
        anchorEntity.addChild(modelEntity)
        anchorEntity.generateCollisionShapes(recursive: true)
        self.scene.addAnchor(anchorEntity)
        
        self.installGestures([.all], for: modelEntity as Entity & HasCollision & HasTransform).forEach { entityGesture in
            entityGesture.addTarget(self, action: #selector(handleEntityGesture(_:)))
        }
        
        self.enableObjectRemoval()
        self.enableTap()
         
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
    
    func compareSIMD3(entityScale: SIMD3<Float>) -> Bool {
        
        let min = SIMD3<Float>(0.9, 0.9, 0.9)
        let max = SIMD3<Float>(1.1, 1.1, 1.1)
        
        if entityScale.x >= min.x && entityScale.y >= min.y && entityScale.z >= min.z && entityScale.x <= max.x && entityScale.y <= max.y && entityScale.z <= max.z {
            print("DEBUG: Equal")
            return true
        } else {
            print("DEBUG: Not equal")
            return false
        }
        
    }
    
    @objc func handleEntityGesture(_ sender: UIGestureRecognizer) {
        
        if let scaleGesture = sender as? EntityScaleGestureRecognizer {
                
                switch scaleGesture.state {
                
                case .began:
                    print("DEBUG: Scale gesture began")
                    
                case .changed:
                    print("DEBUG: Scale gesture changed")
                    print("DEBUG: \(Int(((scaleGesture.entity?.transform.scale.x)! * 100).rounded()))")
                    print("DEBUG: Cazzo \(scaleGesture.scale)")
                    
                    
                    let location = sender.location(in: self)
                    
                    if let entity = self.entity(at: location) {
                        
                        print("DEBUG: Entity Scale Gesture = \(Int(((scaleGesture.entity?.transform.scale.x)! * 100).rounded()))")
                        
                        if compareSIMD3(entityScale: scaleGesture.entity!.transform.scale) == true {
                            
                            
                            if Int((entity.scale.x * 100).rounded()) == 101 {
                                print("DEBUG: Prova \(entity.scale)")
                                entity.scale = [1.1, 1.1, 1.1]
                            } else if Int((entity.scale.x * 100).rounded()) == 99 {
                                print("DEBUG: Prova \(entity.scale)")
                                entity.scale = [0.9, 0.9, 0.9]
                            } else if Int((entity.scale.x * 100).rounded()) == 110 {
                                entity.scale = [1.0, 1.0, 1.0]
                                print("DEBUG: Prova \(entity.scale)")
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            } else if Int((entity.scale.x * 100).rounded()) == 90 {
                                entity.scale = [1.0, 1.0, 1.0]
                                print("DEBUG: Prova \(entity.scale)")
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                            
                            print("DEBUG: Entity Scale = \(Int((entity.scale.x * 100).rounded()))")
                            //UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            //entity.scale = [1.0, 1.0, 1.0]
                        }
                        
                    }
                    
                case .ended:
                    print("DEBUG: Scale gesture ended")
                    
                default:
                    break
                    
                }
                
        }
        
        if let translationGesture = sender as? EntityTranslationGestureRecognizer {
                
                switch translationGesture.state {
                
                case .began:
                    print("DEBUG: Translation gesture began")
                    
                case .changed:
                    print("DEBUG: Translation gesture changed")
                    let currentPos = translationGesture.entity?.transform.translation
                    print("DEBUG: \(currentPos)")
                    
                    let location = sender.location(in: self)
                    
                    if let entity = self.entity(at: location) {
                        
                        if let anchorEntity = entity.anchor {
                            DispatchQueue.main.async { [self] in
                                //UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                print("DEBUG: Something anchor with name: \(anchorEntity.name)")
                                print("DEBUG: Something anchor with name: \(anchorEntity.scale)")
                            }
                        }
                        
                    }
                    
                case .ended:
                    print("DEBUG: Translation gesture ended")
                    
                default:
                    break
                    
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
                    tappedModel = anchorEntity.name
                    isDetailViewActive = true
                    
                }
                
            }
            
        }
    }
    
}
