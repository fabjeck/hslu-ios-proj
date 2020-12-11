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
    
    static func saveMessage(_ text: String, managedObjectContext: NSManagedObjectContext) {
        let newMessage = Message(context: managedObjectContext)
        newMessage.text = text
        newMessage.latitude = 47.193027383614385
        newMessage.longitude = 8.483297528099875
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
