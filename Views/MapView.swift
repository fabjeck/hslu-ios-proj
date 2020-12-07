//
//  MapView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import Mapbox

struct MapView: View {
    @State var annotations: [MGLPointAnnotation] = [
        MGLPointAnnotation(title: "HSLU Rotkreuz", subtitle: "Hochschule Luzern Suurstoffi Rotkreuz", coordinate: .init(latitude: 47.14330, longitude: 8.43238))
    ]
    
    var body: some View {
        MapViewRepresentable(annotations: $annotations).centerCoordinate(.init(latitude: 47.14330, longitude: 8.43238)).zoomLevel(9)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
