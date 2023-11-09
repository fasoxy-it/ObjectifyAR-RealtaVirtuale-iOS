//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI

struct DetailView: View {
    
    var model: Model?
    
    var body: some View {
        
        VStack {
            Image(uiImage: model!.image)
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12)
            Text("\(model!.modelName)")
        }
        
    }
}

#Preview {
    DetailView(model: Model(modelName: "jar"))
}
