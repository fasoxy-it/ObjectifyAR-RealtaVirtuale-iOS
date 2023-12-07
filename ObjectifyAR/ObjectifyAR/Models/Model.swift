//
//  Model.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 31/10/23.
//

import UIKit
import RealityKit
import Combine
import QuickLookThumbnailing

class Modello: Identifiable, ObservableObject {
    
    var id: UUID = UUID()
    var name: String
    @Published var image: UIImage?
    @Published var modelEntity: ModelEntity?
    var dimensions: SIMD3<Float>?
    
    init(url: URL) {
        
        self.name = url.lastPathComponent.replacingOccurrences(of: ".usdz", with: "")
        
        loadImage(url: url)
        loadModel(url: url)
        
    }
    
    func loadModel(url: URL) {
        
        DispatchQueue.main.async {
            do {
                self.modelEntity = try ModelEntity.loadModel(contentsOf: url)
                self.dimensions = self.modelEntity?.model?.mesh.bounds.extents
                print("DEBUG: Successfully loaded modelEntity for modelName: \(self.name)")
            } catch {
                print("DEBUG: Unable to load modelEntity for modelName: \(self.name)")
            }
            
            print("DEBUG: Successfully loaded dimensions for modelName: \(self.name) -> Width:\(self.dimensions?.x), Height:\(self.dimensions?.y), Depth: \(self.dimensions?.z)")
        }
        
    }
    
    func loadImage(url: URL) {
        
        let size = CGSize(width: 150, height: 150)
        let scale = UIScreen.main.scale
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .thumbnail)
        let generator = QLThumbnailGenerator.shared
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    print("DEBUG: Unable to generate thumbnail for modelName: \(self.name)")
                    return
                } else {
                    self.image = thumbnail!.uiImage
                    print("DEBUG: Successfully loaded modelImage for modelName: \(self.name)")
                }
            }
            
        }
    
    }
    
}

class Modelli: ObservableObject {
    
    @Published var modelli: [Modello] = []
    
    func findModello(name: String) -> Modello? {
        return modelli.first { $0.name == name }
    }
    
}
