//
//  MapViewRepresentable.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import Mapbox

extension MGLPointAnnotation {
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.coordinate = coordinate
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @FetchRequest(
        entity: Message.entity(),
        sortDescriptors: []
    ) var messages: FetchedResults<Message>
    
    private let mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: MGLStyle.streetsStyleURL)
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: UIViewRepresentableContext<MapViewRepresentable>) -> MGLMapView {
        mapView.delegate = context.coordinator
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        return mapView
    }
    
    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapViewRepresentable>) {
        updateAnnotations()
    }
    
    func makeCoordinator() -> MapViewRepresentable.Coordinator {
        Coordinator(self)
    }
    
    // MARK: - MGLMapView
    
    func styleURL(_ styleURL: URL) -> MapViewRepresentable {
        mapView.styleURL = styleURL
        return self
    }
    
    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapViewRepresentable {
        mapView.centerCoordinate = centerCoordinate
        return self
    }
    
    func zoomLevel(_ zoomLevel: Double) -> MapViewRepresentable {
        mapView.zoomLevel = zoomLevel
        return self
    }
    
    private func updateAnnotations() {
        let annotations = messages.map({(message) -> MGLPointAnnotation in
                                        return MGLPointAnnotation(coordinate: CLLocationCoordinate2D(latitude: message.latitude, longitude: message.longitude))})
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - MGLMapViewDelegate
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapViewRepresentable
        var timer = Timer()
        
        init(_ control: MapViewRepresentable) {
            self.control = control
        }
        
        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
        
        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            return nil
        }
         
        func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
            return true
        }
        
        func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
            let camera = MGLMapCamera.init(lookingAtCenter: annotation.coordinate, altitude: 4500, pitch: 15, heading: 180)
            mapView.fly(to: camera, withDuration: 4, peakAltitude: 3000, completionHandler: nil)
        }
        
    }
}
