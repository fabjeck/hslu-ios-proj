//
//  LocationService.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 11.12.20.
//

import SwiftUI
import CoreLocation
import CoreData

class LocationService {
    private init(){}
    
    static var globalMsg: StoredMessageModel = StoredMessageModel.sharedInstance
    
    static func checkIfMsgInArea(){
        var noMsgInReach = true
        let userCoordinates = CLLocation(latitude: getUserLatitude(), longitude: getUserLongitude());
        
        // get managed object context from AppDelegate
        let moc = PersistenceManager.persistentContainer.viewContext
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        do {
            let entriesCoreData = try moc.fetch(request)
            for msg in entriesCoreData {
                let msgCoordinates = CLLocation(latitude: msg.latitude, longitude: msg.longitude)
                let distanceInMeters = userCoordinates.distance(from: msgCoordinates)
                if (distanceInMeters <= 10 ){
                    noMsgInReach = false
                    print("du kannst eine message jetzt sehen: ")
                    self.globalMsg.closestMsg = msg
                    print(msg.text)
                }
            }
            if noMsgInReach {
                self.globalMsg.closestMsg = nil
            }
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
            
        }
    }
    
    static func getUserLongitude() -> Double{
        return CLLocationManager().location?.coordinate.longitude ?? 0
    }
    
    static func getUserLatitude() -> Double{
        return CLLocationManager().location?.coordinate.latitude ?? 0
    }
}
