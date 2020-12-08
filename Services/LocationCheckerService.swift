//
//  LocationCheckerService.swift
//  ARLocationMessages
//
//  Created by Marc Häusler on 08.12.20.
//

import Foundation
import CoreLocation

class LocationCheckerService {
    static var app: LocationCheckerService = {
        return LocationCheckerService()
    }()
    
    var closestMessageId = 0
    
   

    func checkIfMessageInReach(pLatitude: Double, pLongitude: Double){
        let userCoordinates = CLLocation(latitude: pLatitude, longitude: pLongitude)
        let coordinateMercHome = CLLocation(latitude: 47.193027383614385, longitude: 8.483297528099875)

        let distanceInMeters = userCoordinates.distance(from: coordinateMercHome)
        if (distanceInMeters <= 10 ){
            print("du kannst eine message jetzt sehen")
        }
    }
    
    func getClosestMessageId() -> Int {
        return self.closestMessageId
    }
}


