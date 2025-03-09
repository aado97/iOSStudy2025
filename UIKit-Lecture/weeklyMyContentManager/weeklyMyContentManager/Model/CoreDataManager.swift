//
//  CoreDataManager.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    // Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostEntity")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Core Data store load failed: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 저장 함수
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    // 새 Post 저장 함수
    func createPost(title: String, date: Date, preview: String, image: UIImage?) -> PostEntity? {
        let newPost = PostEntity(context: context)
        newPost.title = title
        newPost.date = date
        newPost.preview = preview
        if let image = image {
            newPost.imageData = image.jpegData(compressionQuality: 0.8)
        }
        saveContext()
        return newPost
    }
    
    // 모든 Post 불러오기
    func fetchPosts() -> [PostEntity] {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        do {
            let posts = try context.fetch(fetchRequest)
            return posts
        } catch {
            print("Error fetching posts: \(error)")
            return []
        }
    }
}

