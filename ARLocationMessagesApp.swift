//
//  ARLocationMessagesApp.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

@main
struct ARLocationMessagesApp: App {
    var body: some Scene {
        WindowGroup{
            TabView {
                ARView()
                    .tabItem {
                        Image(systemName: "arkit")
                        Text("AR View")
                    }
            }
        }
    }
}
