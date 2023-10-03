//
//  MapViewController.swift
//  Locations
//
//  Created by Haytham on 02/10/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.snapshotView(afterScreenUpdates: true)
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last
        
        Places.shared.userLatitude = currentLocation?.coordinate.latitude ?? 0.0
        Places.shared.userLongitude = currentLocation?.coordinate.longitude ?? 0.0

        let center = CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }
}
