//
//  LocationCheckerService.swift
//  ARLocationMessages
//
//  Created by Marc Häusler on 08.12.20.
//

import Foundation
import CoreData

class PersistenceManager {
    private init(){}
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MessageModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // You should add your own error handling code here.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

