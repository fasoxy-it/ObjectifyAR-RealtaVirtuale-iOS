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

class Modello: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var image: UIImage
    var modelEntity: ModelEntity
    
    init(url: URL) {
        self.name = url.lastPathComponent.replacingOccurrences(of: ".usdz", with: "")
        self.image = UIImage()
        self.modelEntity = ModelEntity()
        
        do {
            loadImage(url: url)
            self.modelEntity = try ModelEntity.loadModel(contentsOf: url)
        } catch {
            fatalError("DEBUG: Unable to load model from URL \(url)")
        }
        
    }
    
    func loadImage(url: URL) {
        let size = CGSize(width: 100, height: 100)
        let scale = UIScreen.main.scale
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .thumbnail)
        let generator = QLThumbnailGenerator.shared
        
        print("DEBUG: Generating thumbnail for modelName: \(url)")
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            print ("DEBUG: \(String(describing: thumbnail))")
            self.image = thumbnail!.uiImage
            
        }
    
    }
    
}

class Modelli: ObservableObject {
    
    @Published var modelli: [Modello] = []
    
    func findModello(name: String) -> Modello? {
        return modelli.first { $0.name == name }
    }
    
}

extension UIImage {
    
    func loadImage(url: URL) {
        let size = CGSize(width: 100, height: 100)
        let scale = UIScreen.main.scale
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .thumbnail)
        let generator = QLThumbnailGenerator.shared
        
        print("DEBUG: Generating thumbnail for modelName: \(url)")
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            print ("DEBUG: \(String(describing: thumbnail))")
            
        }
    
    }
    
}
