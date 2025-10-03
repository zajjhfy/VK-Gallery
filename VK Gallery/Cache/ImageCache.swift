//
//  ImageCache.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

enum ImageCache {
    static let cache = NSCache<NSString, UIImage>()
}
