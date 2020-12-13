//
//  Message+CoreDataProperties.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 13.12.20.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var distance: Double

}

extension Message : Identifiable {

}
