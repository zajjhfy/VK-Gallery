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
        completion: @escaping (Result<PhotoResponse, RError>) -> Void)
    {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266276915&access_token=\(token)&v=5.131")
        else {
            completion(.failure(.requestError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.requestError))
                return
            }
            
            if error != nil {
                completion(.failure(.requestError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestError))
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(PhotoResponse.self, from: data)
                
                completion(.success(response))
            }
            catch{
                completion(.failure(.requestError))
                return
            }
            
        }.resume()
    }
}
