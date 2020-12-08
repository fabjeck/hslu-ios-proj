//
//  LocationCheckerService.swift
//  ARLocationMessages
//
//  Created by Marc Häusler on 08.12.20.
//

import SwiftUI
import CoreLocation
import CoreData

class PersistenceManager {
  let persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "MessagesModel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
            // ToDo: error handling
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  init() {
    // save changes when app goes to background
    let center = NotificationCenter.default
    let notification = UIApplication.willResignActiveNotification

    center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
      guard let self = self else { return }

      if self.persistentContainer.viewContext.hasChanges {
        try? self.persistentContainer.viewContext.save()
      }
    }
  }
}

class LocationCheckerService {
    static var app: LocationCheckerService = {
        return LocationCheckerService()
    }()
    
    
    @FetchRequest(
      entity: MessageLocation.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \MessageLocation.latitude, ascending: true)
      ]
    ) var messages: FetchedResults<MessageLocation>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
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
        let newMessage = MessageLocation(context: managedObjectContext)
        newMessage.latitude = 47.193027383614385
        newMessage.longitude = 8.483297528099875
        newMessage.messageText = "TestMessage Merc Home"
        
        //saveContext()
    }
    
    func saveContext() {
        do {
            try
                managedObjectContext.save()
        } catch {
          // The context couldn't be saved.
          // ToDo: error handling
            print(error)
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    
}


