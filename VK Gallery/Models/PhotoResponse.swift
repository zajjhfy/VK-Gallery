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
    let items: [Item]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case count, items
        case nextFrom = "next_from"
    }
}

struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let canComment: Int
    let sizes: [OrigPhoto]
    let text: String?
    let userID: Int?
    let webViewToken: String
    let hasTags: Bool?
    let likes: Likes
    let comments, reposts, tags: Comments
    let origPhoto: OrigPhoto

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case canComment = "can_comment"
        case sizes, text
        case userID = "user_id"
        case webViewToken = "web_view_token"
        case hasTags = "has_tags"
        case likes, comments, reposts, tags
        case origPhoto = "orig_photo"
    }
}

struct Comments: Codable {
    let count: Int
}

struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

struct OrigPhoto: Codable {
    let height: Int
    let type: TypeEnum
    let url: String
    let width: Int
}

enum TypeEnum: String, Codable {
    case base = "base"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
