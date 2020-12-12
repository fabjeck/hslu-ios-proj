//
//  MessageService.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 11.12.20.
//

import Foundation
import CoreData

class MessageService {
    private init(){}
    
    static func saveMessage(_ text: String, location: CLLocationCoordinate2D, managedObjectContext: NSManagedObjectContext) {
        let newMessage = Message(context: managedObjectContext)
        newMessage.text = text
        newMessage.latitude = location.latitude
        newMessage.longitude = location.longitude
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
