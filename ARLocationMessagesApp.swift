//
//  ARLocationMessagesApp.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import CoreData

class StoredMessageModel: ObservableObject {
    static let sharedInstance = StoredMessageModel()
    @Published var closestMsg: Message?
}

@main
struct ARLocationMessagesApp: App {
    
    let viewContext = PersistenceManager.persistentContainer.viewContext
    
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup{
            TabView {
                MapView()
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Map")
                    }
                ARView()
                    .tabItem {
                        Image(systemName: "arkit")
                        Text("AR View")
                    }
            }.environment(\.managedObjectContext, viewContext)
        }.onChange(of: scenePhase) { (phase) in
            if phase == .background {
                PersistenceManager.saveContext()
            }
        }
    }
}




