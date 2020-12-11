//
//  MapViewModel.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

extension MapView {
    class MapViewModel: ObservableObject {
        @Published var show = false
        
        @FetchRequest(
            entity: Message.entity(),
            sortDescriptors: []
        ) var messages: FetchedResults<Message>
        
        func openModal() {
            show = true
        }
    }
}
