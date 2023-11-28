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
    var modelEntity: ModelEntity?
    
    private var cancellableImage: AnyCancellable? = nil
    private var cancellableModelEntity: AnyCancellable? = nil
    
    init(url: URL) {
        self.name = url.lastPathComponent.replacingOccurrences(of: ".usdz", with: "")
        //self.image = UIImage()
        //self.modelEntity = ModelEntity()
        
        loadImage(url: url)
        
        
        
        self.cancellableModelEntity = ModelEntity.loadModelAsync(contentsOf: url)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error):
                    print("DEBUG: Unable to load modelEntity for modelName: \(self.name)")
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { m in
                self.modelEntity = m
                print("DEBUG: ITA Successfully loaded modelEntity for modelName: \(self.name)")
            })
        
    }
    
    func loadImage(url: URL) {
        let size = CGSize(width: 100, height: 100)
        let scale = UIScreen.main.scale
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .thumbnail)
        let generator = QLThumbnailGenerator.shared
        
        print("DEBUG: Generating thumbnail for modelName: \(url)")
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    print("DEBUG: Unable to generate thumbnail for modelName: \(url)")
                    return
                } else {
                    self.image = thumbnail!.uiImage
                    print("DEBUG: ITA Successfully loaded modelImage for modelName: \(self.name)")
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
