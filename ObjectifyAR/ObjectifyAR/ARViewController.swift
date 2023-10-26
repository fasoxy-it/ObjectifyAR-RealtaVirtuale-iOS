//
//  ARViewController.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 26/10/23.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewController: UIViewRepresentable {
    
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}
