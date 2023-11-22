//
//  ModelPicker.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 21/11/23.
//

import SwiftUI

struct ModelPicker: View {
    
    var model: Modello

    var body: some View {
        
        VStack {
            Text(model.name)
        }
    }
    
}
