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
        
        ScrollView {
            VStack {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.bottom, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                    VStack {
                        Text(model!)
                        
                    }
                    
                }
                
            }
        }
        
    }

}
