//
//  ContentView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 26/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
