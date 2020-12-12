//
//  MapView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import Mapbox

struct MapView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var vm = MapViewModel()
    
    var body: some View {
        MapViewRepresentable()
            .centerCoordinate(.init(latitude: 47.14330, longitude: 8.43238))
            .zoomLevel(9)
            .overlay(
                Button(action: {
                    vm.openModal()
                }, label: {
                    Text("Message verfassen")
                }).buttonStyle(CustomButtonStyle(.secondary))
                .padding()
                .sheet(isPresented: $vm.show, content: {
                    MessageView()
                        .environment(\.managedObjectContext, viewContext)
                }),
                alignment: .bottom
            ).edgesIgnoringSafeArea(.top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
