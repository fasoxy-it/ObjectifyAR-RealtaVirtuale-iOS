//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI

struct DetailView: View {
    
    var model: String?
    
    var body: some View {
        Text("Hello, \(model!)")
    }
}

#Preview {
    DetailView(model: "jar")
}
