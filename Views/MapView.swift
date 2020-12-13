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
    
    @EnvironmentObject var locationManager: LocationManager
    
    @ObservedObject var vm = MapViewModel()
    
    var body: some View {
        MapViewRepresentable()
            .centerCoordinate(.init(latitude: 47.14330, longitude: 8.43238))
            .zoomLevel(9)
            .overlay(
                Group {
                    Button(action: {
                        vm.openModal()
                    }, label: {
                        Text(NSLocalizedString("write_msg", comment: ""))
                    }).buttonStyle(CustomButtonStyle(.secondary))
                    .padding()
                    .sheet(isPresented: $vm.show, content: {
                        MessageView()
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(locationManager)
                    })
                    Label(NSLocalizedString("click_here", comment: ""), systemImage: "arrow.down").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20, alignment: .bottomTrailing)
                        .padding(.trailing)
                        .background(Color.green)
                        .opacity(!locationManager.availableMessage.isEmpty ? 1 : 0)
                },
                alignment: .bottom
            ).edgesIgnoringSafeArea(.top)
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


