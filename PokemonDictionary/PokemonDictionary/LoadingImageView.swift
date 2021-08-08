//
//  LoadingImageView.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/08.
//

import Foundation
import UIKit

class LoadingImageView: UIImageView {
    
    func loadImage(with urlString: String) {
        let width = self.frame.size.width
        let targetSize = CGSize(width: width,
                                height: width)
        
        let emptyImage = UIImage(named: "placeholder") ?? UIImage()
        self.image = self.resizeImage(image: emptyImage, targetSize: targetSize)
        
        guard let url = URL(string: urlString) else { return }
        API.shared.getData(from: url) { result in
            switch result {
            case .success(let datas):
                guard let imageData = datas,
                      let loadedImage = UIImage(data: imageData) else { return }
                
                DispatchQueue.main.async {
                    let resized = self.resizeImage(image: loadedImage,
                                                   targetSize: targetSize)
                    self.image = resized
                }
                
            case .failure(let error):
                print(error.errorDescription ?? "error occured when loading an image")
            }
           
        }
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let ratioToAdjust  = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratioToAdjust,
                         height: size.height * ratioToAdjust)

        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
