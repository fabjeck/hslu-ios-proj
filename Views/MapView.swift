//
//  MapView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import Mapbox

struct MapView: View {
    @ObservedObject var vm = MapViewModel()
    
    @State var annotations: [MGLPointAnnotation] = [
        MGLPointAnnotation(title: "HSLU Rotkreuz", subtitle: "Hochschule Luzern Suurstoffi Rotkreuz", coordinate: .init(latitude: 47.14330, longitude: 8.43238))
    ]
    
    var body: some View {
        MapViewRepresentable(annotations: $annotations)
            .centerCoordinate(.init(latitude: 47.14330, longitude: 8.43238))
            .zoomLevel(9)
            .overlay(
                Button(action: {
                    vm.toggleModal()
                }, label: {
                    Text("Nachricht erfassen")
                }).buttonStyle(CustomButtonStyle(.secondary))
                .padding()
                .sheet(isPresented: $vm.showMessageView, content: {
                    MessageView(vm: MessageView.MessageViewModel(showMessageView: $vm.showMessageView))
                }),
                alignment: .bottom
            )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
