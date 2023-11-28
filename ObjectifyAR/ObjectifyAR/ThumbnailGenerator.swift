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

class ThumbnailGenerator {
    
    var thumbnailImage: UIImage?
    
    func generateThumbnail(for url: URL) {
        
        let size = CGSize(width: 100, height: 100)
        
        let scale = UIScreen.main.scale
        
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
        
        let generator = QLThumbnailGenerator.shared
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    print("DEBUG: Unable to generate thumbnail for modelName: \(url)")
                    return
                } else {
                    self.thumbnailImage = thumbnail!.uiImage
                }
            }
        }
        
    }
    
}
