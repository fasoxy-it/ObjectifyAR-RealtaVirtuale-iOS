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
    @Binding var selectedModel: Model?
    @State var modelE: ModelEntity?
    
    var models: [Model]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count) { index in
                    Button(action: {
                        print("DEBUG: Selected model with name: \(models[index].modelName)")
                        selectedModel = models[index]
                    }) {
                        ModelPicker(model: models[index])
                        
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
                        $modelE.wrappedValue = try ModelEntity.loadModel(contentsOf: fileUrl)
                        print("DEBUG: ModelEntity: \(String(describing: modelE))")
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

#Preview {
    ModelPickerView(selectedModel: .constant(Model(modelName: "jar")), models: [Model(modelName: "jar")])
}
