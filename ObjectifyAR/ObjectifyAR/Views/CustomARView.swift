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
    @Binding var tappedModel: Model
    @Binding var audioPlayer: AVAudioPlayer!
    
    
    //var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect, isDetailViewActive: Binding<Bool>, tappedModel: Binding<Model>, audioPlayer: Binding<AVAudioPlayer?>) {
        
        self._isDetailViewActive = isDetailViewActive
        self._tappedModel = tappedModel
        self._audioPlayer = audioPlayer
        
        
        
        super.init(frame: frameRect)
        
        focusSquare.viewDelegate = self
        focusSquare.delegate =  self
        focusSquare.setAutoUpdate(to: true)
        
        self.setupARView()
        
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @MainActor override required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
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
                playAudio()
                print("DEBUG: Removed anchor with name: \(anchorEntity.name)")
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
                print("DEBUG: Tapped anchor with name: \(anchorEntity.name)")
                isDetailViewActive = true
                tappedModel = Model(modelName: anchorEntity.name) 
                
            }
            
        }
    }
    
    func playAudio() {
        
        print("DEBUG: Playing audio")
        
        if let soundURL = Bundle.main.url(forResource: "sound", withExtension: "mp3") {
            
            do {
                print("DEBUG: Effectively playing audio")
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.play()
            } catch {
                print("DEBUG: Unable to play audio")
            }
            
        }
        
    }
    
}

extension CustomARView: FEDelegate {
    
    func toTrackingState() {
        
    }
    
    func toInitializingState() {
        
    }
    
}
