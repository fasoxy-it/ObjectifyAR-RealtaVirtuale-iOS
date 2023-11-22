//
//  ModelPickerView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 09/11/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ModelPickerView: View {
    
    @State var isImporting: Bool = false
    @Binding var selectedModel: Modello?
    //@State var modelE: ModelEntity?
    
    var thumbnail: Image?
    
    @ObservedObject var thumbnailGenerator = ThumbnailGenerator()
    
    //var modello: Modello = Modello()
    var modelli: Modelli
    
    //var models: [Model]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(modelli.modelli) { modello in
                    Button(action: {
                        print("DEBUG: Selected model with name: \(modello.name)")
                        selectedModel = modello
                    }) {
                        Text(modello.name)
                        //ModelPicker(model: models[index])
                        
                    }
                        .buttonStyle(PlainButtonStyle())
                }
                Button("Add") {
                    print("DEBUG: Add button pressed")
                    isImporting = true
                }.fileImporter(isPresented: $isImporting, allowedContentTypes: [.usdz]) { result in
                    do {
                        let fileUrl = try result.get()
                        print("DEBUG: File URL: \(fileUrl)")
                        
                        guard fileUrl.startAccessingSecurityScopedResource() else { return }
                        
                        modelli.modelli.append(Modello(name: fileUrl.lastPathComponent.replacingOccurrences(of: ".usdz", with: ""), /*image: thumbnail!,*/ modelEntity: try ModelEntity.loadModel(contentsOf: fileUrl)))
                        
                        fileUrl.stopAccessingSecurityScopedResource()
                        
                        isImporting = false
                    
                    } catch {
                        print("DEBUG: Error getting file URL: \(error.localizedDescription)")
                    }
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
        
    }
    
    
    
}




