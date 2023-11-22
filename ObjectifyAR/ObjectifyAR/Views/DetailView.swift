//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI
import RealityKit

struct DetailView: View {
    
    @State var isImporting: Bool = false
    @State var image: UIImage?
    @State var modelE: ModelEntity?
    
    
    let placeHolder = Image(systemName: "photo")
    
    
    
    @ObservedObject var thumbnailGenerator = ThumbnailGenerator()
    
    
    
    var model: Model?
    
    var body: some View {
        
        VStack {
            
            self.thumbnailGenerator.thumbnailImage != nil ? self.thumbnailGenerator.thumbnailImage!
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12) : placeHolder
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12)
            
            Image(uiImage: $image.wrappedValue ?? UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12)
            Image(uiImage: model!.modelImage)
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(12)
            Text("\(model!.modelName)")
            Button("Thmbnail") {
                print("DEBUG: Thumbnail button tapped")
                self.thumbnailGenerator.generateThumbnail(for: model!.modelName, size: CGSize(width: 80, height: 80))
            }
            Button("Button") {
                print("DEBUG: Download button tapped")
                isImporting = true
                getData()
            }.fileImporter(isPresented: $isImporting, allowedContentTypes: [.png]) { result in
                do {
                    let fileUrl = try result.get()
                    print("DEBUG: File URL: \(fileUrl)")
                    guard fileUrl.startAccessingSecurityScopedResource() else { return }
                    $image.wrappedValue = try UIImage(data: Data(contentsOf: fileUrl))!
                    fileUrl.stopAccessingSecurityScopedResource()
                    
                    isImporting = false
                
                } catch {
                    print("DEBUG: Error getting file URL: \(error.localizedDescription)")
                }
            }
            
        }
        
    }
    
    func getData() {
        
        let filemanager = FileManager.default
        //let path = Bundle.main.resourcePath!
        
        do {
            
            let documentsURL = try filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            //let items = try filemanager.contentsOfDirectory(atPath: path)
            
            let items = try filemanager.contentsOfDirectory(atPath: documentsURL.path)
                    
            
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
