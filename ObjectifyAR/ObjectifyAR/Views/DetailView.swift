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
        Text("Hello, \(model!.modelName)")
    }
}

#Preview {
    DetailView(model: Model(modelName: "jar"))
}
