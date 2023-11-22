//
//  ModelPicker.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 21/11/23.
//

import SwiftUI

struct ModelPicker: View {
    
    @ObservedObject var thumbnailGenerator = ThumbnailGenerator()
    
    var model: Model
    
    init(model: Model) {
        self.model = model
        self.thumbnailGenerator.generateThumbnail(for: model.modelName, size: CGSize(width: 80, height: 80))
    }
    
    var body: some View {
        VStack {
            self.thumbnailGenerator.thumbnailImage != nil ? self.thumbnailGenerator.thumbnailImage!
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12) : Image(systemName: "photo")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12)
            Text(model.modelName)
        }
    }
    
}

#Preview {
    ModelPicker(model: Model(modelName: "jar"))
}
