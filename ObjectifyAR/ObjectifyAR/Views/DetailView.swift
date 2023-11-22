//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI
import RealityKit

struct DetailView: View {
    
    var model: String?
    
    var body: some View {
        
        VStack {
            Text(model!)
        }
        
    }

}
