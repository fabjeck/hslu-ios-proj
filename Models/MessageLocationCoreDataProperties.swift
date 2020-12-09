//
//  MessageLocation+CoreDataProperties.swift
//  ARLocationMessages
//
//  Created by Marc Häusler on 08.12.20.
//
//

import Foundation
import CoreData


extension MessageLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageLocation> {
        return NSFetchRequest<MessageLocation>(entityName: "MessageLocation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var messageText: String?

}
