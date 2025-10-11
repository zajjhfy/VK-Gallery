//
//  Photo+CoreDataProperties.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 11.10.2025.
//
//

import Foundation
import CoreData


extension Photo {

    @NSManaged public var id: Int32
    @NSManaged public var postedAt: String?
    @NSManaged public var url: String?
    @NSManaged public var likesCount: Int32
    @NSManaged public var commentsCount: Int32

}

extension Photo : Identifiable { }
