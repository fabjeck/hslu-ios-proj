//
//  ARLocationMessagesApp.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import CoreData

@main
struct ARLocationMessagesApp: App {
    
    let context = PersistenceManager.persistentContainer.viewContext
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
            }.environment(\.managedObjectContext, context)
        }.onChange(of: scenePhase) { (phase) in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("bg")
                PersistenceManager.saveContext()
            @unknown default:
                print("error in scenechange")
            }
        }
    }
}




