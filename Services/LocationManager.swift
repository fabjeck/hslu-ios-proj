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
        availableMessage = getClosestMessageInRange(location)
    }
}

class LocationManager: NSObject, ObservableObject {
    @Published var availableMessage: String = ""
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    lazy var userCoordinates: CLLocationCoordinate2D = {
        return locationManager.location!.coordinate
    }()
    
    private func getClosestMessageInRange(_ location: CLLocation) -> String {
        let moc = PersistenceManager.persistentContainer.viewContext
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        do {
            let messages = try moc.fetch(request)
            messages.forEach {$0.distance = CLLocation(latitude: $0.longitude, longitude: $0.latitude).distance(from: location)}
            let messagesInRange = messages.filter {$0.distance >= 5}
            if (!messagesInRange.isEmpty) {
                let closestInRange = messagesInRange.min(by: {$0.distance < $1.distance})
                return closestInRange?.text ?? ""
            } else {
                return ""
            }
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
            return ""
        }
    }
}
