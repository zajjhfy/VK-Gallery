//
//  ErrorResponse.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

struct ErrorResponse: Codable {
    let error: APIError
}
struct APIError: Codable {
    let errorCode: Int
    let errorMsg: String
}
