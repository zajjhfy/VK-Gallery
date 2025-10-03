//
//  RequestManager.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

final class RequestManager {
    static let shared = RequestManager()
    
    func getAlbumPhotosRequest(
        with token: String,
        completion: @escaping (Result<[PhotoInfo], RError>) -> Void)
    {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266276915&access_token=\(token)&v=5.131")
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
                
                if let error = try? jsonDecoder.decode(ErrorResponse.self, from: data){
                    completion(.failure(.vkApiError))
                    return
                }
                
                let response = try jsonDecoder.decode(PhotoResponse.self, from: data)
                
                var photos: [PhotoInfo] = []
                
                for item in response.response.items {
                    let photoInfo = PhotoInfo(imageUrl: item.origPhoto.url, postedAtDate: item.date.convertToStringDateFromTimestamp())
                    
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
}
