//
//  MapViewRepresentable.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI
import Mapbox

extension MGLPointAnnotation {
    convenience init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var annotations: [MGLPointAnnotation]
    
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
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - MGLMapViewDelegate
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapViewRepresentable
        var locationChecker = LocationCheckerService()
        var timer = Timer()
        
        init(_ control: MapViewRepresentable) {
            self.control = control
        }
        
        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            //start tracking
            timer =  Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true)
            {
                (timer) in
                self.checkLocationWithMessages(mapView)
            }
        }
        
        func checkLocationWithMessages(_ mapView: MGLMapView){
            print(mapView.userLocation?.coordinate ?? "no value")
            if mapView.userLocation?.coordinate != nil {
                let userLatitude = (mapView.userLocation?.coordinate.latitude)!
                let userLongitude = (mapView.userLocation?.coordinate.longitude)!
                locationChecker.checkIfMessageInReach(pLatitude: userLatitude, pLongitude: userLongitude)
            }
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
