//
//  RequestManager.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

final class RequestManager {
    static let shared = RequestManager()
    
    func getAlbumPhotosRequest(
        with token: String,
        completion: @escaping (Result<[PhotoInfo], RError.FetchDataError>) -> Void)
    {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?owner_id=-60154984&album_id=274932301&extended=1&access_token=\(token)&v=5.131")
        else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.requestError))
                return
            }
            
            if error != nil {
                completion(.failure(.someError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
        
            do{
                let jsonDecoder = JSONDecoder()
                
                // DEBUG
//                let jsonString = String(data: data, encoding: .utf8)
//                print(jsonString ?? "Неудачная конвертация")

                let response = try jsonDecoder.decode(PhotoResponse.self, from: data)
                
                var photos: [PhotoInfo] = []
                
                for item in response.response.items {
                    let photoInfo = PhotoInfo(imageId: item.id, imageUrl: item.origPhoto.url, postedAtDate: item.date.convertToStringDateFromTimestamp(), commentsCount: item.comments.count, likesCount: item.likes.count)
                    
                    photos.append(photoInfo)
                }
                
                completion(.success(photos))
            }
            catch{
                completion(.failure(.retrivingDataError))
                return
            }
            
        }.resume()
    }
    
    func getCommentsByPhotoId(in photoId: Int, with token: String){
        guard let url = URL(string: "https://api.vk.com/method/photos.getComments?photo_id=\(photoId)&access_token=\(token)&v=5.131")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                return
            }
            
            guard let data = data else {
                
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString ?? "Неудачная конвертация")
            
            
        }.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, RError.DownloadError>) -> Void){
        let cache = ImageCache.cache
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async{ completion(.success(image)) }
            return
        }
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async{ completion(.failure(.imageDownloadGeneralError)) }
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                DispatchQueue.main.async{ completion(.failure(.imageDownloadGeneralError)) }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async{ completion(.failure(.imageDownloadGeneralError)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async{ completion(.failure(.imageDownloadGeneralError)) }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async{ completion(.failure(.imageDownloadGeneralError)) }
                return
            }
            
            cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async{ completion(.success(image)) }
            
        }.resume()
    }
}
