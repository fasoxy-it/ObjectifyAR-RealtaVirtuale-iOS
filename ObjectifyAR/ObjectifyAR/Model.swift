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
    
    init(name: String, /*image: Image,*/ modelEntity: ModelEntity) {
        self.name = name
        //self.image = image
        self.modelEntity = modelEntity
    }
    
}

class Modelli {
    
    var modelli: [Modello] = []
}
