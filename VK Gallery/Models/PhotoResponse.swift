//
//  PhotoResponse.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

struct PhotoResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [PhotoItem]
    let nextFrom: String?  

    enum CodingKeys: String, CodingKey {
        case count, items
        case nextFrom = "next_from"
    }
}

struct PhotoItem: Codable {
    let albumID: Int
    let date: Int
    let id: Int
    let ownerID: Int
    let sizes: [PhotoSize]
    let text: String?
    let userID: Int?
    let hasTags: Bool?
    let origPhoto: PhotoSize?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case origPhoto = "orig_photo"
    }
}

struct PhotoSize: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
