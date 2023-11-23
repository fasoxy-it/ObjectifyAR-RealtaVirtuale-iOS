//
//  Model.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 31/10/23.
//

import UIKit
import RealityKit
import Combine
import SwiftUI

class Modello: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    //var image: Image
    var modelEntity: ModelEntity
    
    init(url: URL) {
        self.name = url.lastPathComponent.replacingOccurrences(of: ".usdz", with: "")
        //self.image = image
        do {
            self.modelEntity = try ModelEntity.loadModel(contentsOf: url)
        } catch {
            fatalError("DEBUG: Unable to load model from URL \(url)")
        }
        
    }
    
}

class Modelli {
    
    var modelli: [Modello] = []
    
}
