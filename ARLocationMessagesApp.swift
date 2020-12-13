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
    
    let viewContext = PersistenceManager.persistentContainer.viewContext

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
            .environmentObject(LocationManager())
        }
    }
}




