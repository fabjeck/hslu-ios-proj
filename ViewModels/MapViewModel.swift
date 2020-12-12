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
        
        func openModal() {
            show = true
        }
    }
}
