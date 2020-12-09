//
//  LocationCheckerService.swift
//  ARLocationMessages
//
//  Created by Marc Häusler on 08.12.20.
//

import SwiftUI
import CoreLocation
import CoreData

public class PersistenceManager {
  public static var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "MessagesModel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
            // ToDo: error handling
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()
    
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public static func saveContext() {
        let context = persistentContainer.viewContext
//        let container = NSPersistentContainer(name: "MessagesModel")
//          print(container.persistentStoreDescriptions.first?.url)
        if context.hasChanges {
            do {
                try
                    context.save()
            } catch {
              // The context couldn't be saved.
              // ToDo: error handling
                print(error)
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        else {
            print("no changes found")
        }
        
      }
}

class MessageService {
    static var app: MessageService = {
        return MessageService()
    }()
    
    
    @FetchRequest(
      entity: MessageLocation.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \MessageLocation.latitude, ascending: true)
      ]
    ) var messages: FetchedResults<MessageLocation>
    
    var closestMessageId = 0
    
    func getClosestMessageId() -> Int {
        return self.closestMessageId
    }

    func checkIfMessageInReach(pLatitude: Double, pLongitude: Double){
        let userCoordinates = CLLocation(latitude: pLatitude, longitude: pLongitude)
        let coordinateMercHome = CLLocation(latitude: 47.193027383614385, longitude: 8.483297528099875)

        print(messages)
        let distanceInMeters = userCoordinates.distance(from: coordinateMercHome)
        if (distanceInMeters <= 10 ){
            print("du kannst eine message jetzt sehen")
        }
    }
    
    func addMessageToCore(){
        let newMessage = MessageLocation(context: PersistenceManager.persistentContainer.viewContext)
        newMessage.latitude = 47.193027383614385
        newMessage.longitude = 8.483297528099875
        newMessage.messageText = "TestMessage Merc Home"
        
        PersistenceManager.saveContext()
    }
    
    
    
}


