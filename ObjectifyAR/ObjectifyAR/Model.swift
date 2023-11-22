//
//  Model.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 31/10/23.
//

import UIKit
import RealityKit
import Combine

class Model {
    
    var modelName: String
    var modelImage: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.modelImage = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error):
                    // Handle our error
                    print("DEBUG: Unable to load modelEntity for modelName: \(self.modelName) -> \(error)")
                case .finished:
                    break // Non hai bisogno di fare nulla qui nel tuo caso
                }
            }, receiveValue: { modelEntity in
                // Get our modelEntity
                self.modelEntity = modelEntity
                print("DEBUG: Successfully loaded modelEntity for modelName: \(self.modelName)")
                print("MODEL: \(String(describing: self.modelEntity))")
            })
        
    }
    
}

class Models {
    
    var models: [Model] = []
    
}
