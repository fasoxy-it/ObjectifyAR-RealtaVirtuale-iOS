//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI

struct DetailView: View {
    
    @State var isImporting: Bool = false
    
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
            Button("Button") {
                print("DEBUG: Download button tapped")
                isImporting = true
                //getData()
            }.fileImporter(isPresented: $isImporting, allowedContentTypes: [.usdz]) { result in
                do {
                    let fileUrl = try result.get()
                    print("DEBUG: File URL: \(fileUrl)")
                    isImporting = false
                
                } catch {
                    print("DEBUG: Error getting file URL: \(error.localizedDescription)")
                }
            }
        
        }
        
    }
    
    func getData() {
        
        let filemanager = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try filemanager.contentsOfDirectory(atPath: path)
            
            for item in items {
                print("DEBUG: Item: \(item)")
            
            }
        } catch {
            print("DEBUG: Error getting items from directory: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    DetailView(model: Model(modelName: "jar"))
}
