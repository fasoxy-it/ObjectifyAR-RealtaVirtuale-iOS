//
//  ContentView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 29/10/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import AVKit

struct ContentView : View {
    
    @StateObject var modelli: Modelli = Modelli()
    
    @State private var selectedModel: Modello?
    @State private var tappedModel: Modello?
    @State private var isDetailViewActive: Bool = false
    @State private var isImporting: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                NavigationLink(destination: DetailView(model: $tappedModel), isActive: $isDetailViewActive) {
                    EmptyView()
                }
                
                CustomARViewContainer(selectedModel: $selectedModel, isDetailViewActive: $isDetailViewActive, tappedModel: $tappedModel)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                            .onTapGesture {
                                print("DEBUG: Add button pressed")
                                isImporting = true
                            }
                            .fileImporter(isPresented: $isImporting, allowedContentTypes: [.usdz]) { result in
                                do {
                                    let fileUrl = try result.get()
                                    print("DEBUG: File URL: \(fileUrl)")
                                    
                                    guard fileUrl.startAccessingSecurityScopedResource() else { return }
                                    
                                    modelli.modelli.append(Modello(url: fileUrl))
                                    
                                    print("DEBUG: Added model with name: \(modelli.modelli.last!.name)")
                                    print("DEBUG: Added model with name: \(modelli.modelli.last!.image)")
                                    print("DEBUG: Added model with name: \(modelli.modelli.last!.modelEntity)")
                                    
                                    //fileUrl.stopAccessingSecurityScopedResource()
                                    
                                    isImporting = false
                                
                                } catch {
                                    print("DEBUG: Error getting file URL: \(error.localizedDescription)")
                                }
                            }
                            .padding(.trailing, 10)
                            .padding(.top, 10)
                           
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            DocumentationView()
                        } label: {
                            Image(systemName: "info.square.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.lightGray)
                                
                        }
                        .padding(.trailing, 10)
                        
                    }
                    
                    
                    
                    Spacer()
                    
                    if modelli.modelli.count > 0 {
                        
                        ModelPickerView(selectedModel: $selectedModel)
                            
                    }
                    
                }
                
            }
            
        }.environmentObject(modelli)
        
    }
    
}
