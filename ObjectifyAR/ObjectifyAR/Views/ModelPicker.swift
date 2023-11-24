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
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 120)
                VStack {
                    Image(uiImage: model.image)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .aspectRatio(1/1, contentMode: .fit)
                        .background(Color.white)
                        .cornerRadius(12)
                    Text(model.name)
                }
                
            }
            
        }
        
    }
    
}
