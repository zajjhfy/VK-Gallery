//
//  PersistentManager.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 11.10.2025.
//

import UIKit
import CoreData

final class PersistentManager {
    
    static let shared = PersistentManager()
    
    private init() { }
    
    private let appDelegate: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    func createPhoto(id: Int, url: String, postedAt: String, commentsCount: Int, likesCount: Int) -> Bool {
        let photoIn = getPhoto(id)
        
        if photoIn != nil { return false }
        
        guard let photoDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return false }
        
        let photo = Photo(entity: photoDescription, insertInto: context)
        
        photo.id = Int32(id)
        photo.url = url
        photo.postedAt = postedAt
        photo.commentsCount = Int32(commentsCount)
        photo.likesCount = Int32(likesCount)
        photo.date = Date()
        
        appDelegate.saveContext()
        return true
    }
    
    func createPhoto(photoInfo: PhotoInfo) -> Bool {
        let photoIn = getPhoto(photoInfo.imageId)
        
        if photoIn != nil { return false }
        
        guard let photoDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return false }
        
        let photo = Photo(entity: photoDescription, insertInto: context)
        
        photo.id = Int32(photoInfo.imageId)
        photo.url = photoInfo.imageUrl
        photo.postedAt = photoInfo.postedAtDate
        photo.commentsCount = Int32(photoInfo.commentsCount)
        photo.likesCount = Int32(photoInfo.likesCount)
        photo.date = Date()
        
        appDelegate.saveContext()
        return true
    }

    func getPhoto(_ id: Int) -> Photo? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            let photo = try context.fetch(request) as? [Photo]
            return photo?.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getPhotos() -> [Photo] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do{
            let photos = try context.fetch(request) as! [Photo]
            return photos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getPhotos(by category: FilterMenu.MenuState, sort: FilterMenu.SortBy) -> [Photo] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        var key = ""
        
        switch category {
        case .comments:
            key = "commentsCount"
        case .datePublished:
            key = "postedAt"
        case .likes:
            key = "likesCount"
        case .recent:
            key = "date"
        }
        
        let sortDescriptor = NSSortDescriptor(key: key, ascending: sort.rawValue == "Ascending" ? true : false)
        request.sortDescriptors = [sortDescriptor]
        
        do{
            let photos = try context.fetch(request) as! [Photo]
            return photos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deletePhoto(_ id: Int32) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            let photo = try context.fetch(request) as! [Photo]
            
            guard let photo = photo.first else { return false }
            context.delete(photo)
            appDelegate.saveContext()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
