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
    @ObservedObject var globalMsg: StoredMessageModel = StoredMessageModel.sharedInstance
    
    @State var annotations: [MGLPointAnnotation] = [
        // Change to go through dynamic array of annotations
        MGLPointAnnotation(title: "HSLU Rotkreuz", subtitle: "Hochschule Luzern Suurstoffi Rotkreuz", coordinate: .init(latitude: 47.14330, longitude: 8.43238)),
        
        MGLPointAnnotation(title: "Merc Home", subtitle: "cool place to be", coordinate: .init(latitude: 47.193027383614385, longitude: 8.483297528099875)),
        
        MGLPointAnnotation(title: "Fabien Home", subtitle: "also cool place to be", coordinate: .init(latitude: 47.04949980488132, longitude: 8.266468592629026))
    ]
    
    var body: some View {
        MapViewRepresentable(annotations: $annotations)
            .centerCoordinate(.init(latitude: 47.14330, longitude: 8.43238))
            .zoomLevel(9)
            .overlay(
                Group {
                    Button(action: {
                        vm.openModal()
                    }, label: {
                        Text("Message verfassen")
                    }).buttonStyle(CustomButtonStyle(.secondary))
                    .padding()
                    .sheet(isPresented: $vm.show, content: {
                        MessageView()
                            .environment(\.managedObjectContext, viewContext)
                    })
                    Label("click here", systemImage: "arrow.down").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20, alignment: .bottomTrailing)
                        .padding(.trailing)
                        .background(Color.green)
                        .opacity(((self.globalMsg.closestMsg) != nil) ? 1 : 0)
//                    Text("\(globalMsg.closesMsg?.text ?? "nil")")
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


