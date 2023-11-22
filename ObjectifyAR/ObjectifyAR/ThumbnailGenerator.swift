//
//  ThumbnailGenerator.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 21/11/23.
//

import QuickLookThumbnailing
import SwiftUI
import Combine
import UIKit

class ThumbnailGenerator: ObservableObject {
    
    @Published var thumbnailImage: Image?
    
    func generateThumbnail(for resource: String, withExtension: String = "usdz", size: CGSize) {
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: withExtension) else {
            print("DEBUG: Unable to find modelURL for modelName: \(resource)")
            return
        }
        
        let scale = UIScreen.main.scale
        
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
        
        let generator = QLThumbnailGenerator.shared
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    print("DEBUG: Unable to generate thumbnail for modelName: \(resource)")
                    return
                } else {
                    self.thumbnailImage = Image(uiImage: thumbnail!.uiImage)                
                }
            }
        }
        
    }
    
}
