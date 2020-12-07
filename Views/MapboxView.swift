//
//  ViewController.swift
//  MapsTest
//
//  Created by Marc Häusler on 23.11.20.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 47.14330, longitude: 8.43238), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
        
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 47.14330, longitude: 8.43238)
        annotation.title = "HSLU Rotkreuz"
        annotation.subtitle = "Hochschule Luzern Suurstoffi Rotkreuz"
        mapView.addAnnotation(annotation)
        
        // Set the map view's delegate
        mapView.delegate = self
         
        // Allow the map view to display the user's location
//        mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    // Always allow callouts to popup when annotations are tapped.
    return true
    }
     
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4500, pitch: 15, heading: 180)
    mapView.fly(to: camera, withDuration: 4,
    peakAltitude: 3000, completionHandler: nil)
    }
}

