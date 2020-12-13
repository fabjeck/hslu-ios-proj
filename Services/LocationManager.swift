//
//  LocationManager.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 12.12.20.
//

import Foundation
import CoreLocation
import CoreData

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let location = locations.first else { return }
        self.location = location.coordinate
    }
}

class LocationManager: NSObject, ObservableObject {
    @Published var location = CLLocationCoordinate2D()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func getClosestMessageInRange(messages: [Message]) -> String {
        messages.forEach {$0.distance = CLLocation(latitude: $0.latitude, longitude: $0.longitude).distance(from: locationManager.location!)}
        let messagesInRange = messages.filter {$0.distance <= 5}
        if (!messagesInRange.isEmpty) {
            let closestInRange = messagesInRange.min(by: {$0.distance < $1.distance})
            return closestInRange?.text ?? ""
        } else {
            return ""
        }
    }
}
