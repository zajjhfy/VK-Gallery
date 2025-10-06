//
//  ImageView+Ext.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String, downloadSuccess: @escaping () -> Void){
        let cache = ImageCache.cache
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                
                self.image = image
                downloadSuccess()
            }
            
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            guard let self = self else { return }
            
            if let _ = error { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async{
                self.image = image
                downloadSuccess()
            }
            
        }.resume()
    }
}
