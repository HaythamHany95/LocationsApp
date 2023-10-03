//
//  PlacesViewController.swift
//  Locations
//
//  Created by Haytham on 02/10/2023.
//

import UIKit
import RealmSwift
import MapKit
import CoreLocation

class PlacesViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        
        let landmarks = realm.objects(Landmark.self)
        Places.shared.landmarks = landmarks
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        print(Places.shared.landmarks ?? "")
    }
    
}
extension PlacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Places.shared.landmarks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        
        guard let bookmark = Places.shared.landmarks?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.place.text = bookmark.name
        cell.time.text = DateFormatter.localizedString(from: bookmark.time, dateStyle: .medium, timeStyle: .short)
        cell.desc.text = bookmark.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let deletedBookmark = Places.shared.landmarks?[indexPath.row] else { return }
        
        try! realm.write {
            realm.delete(deletedBookmark)
        }
        tableView.reloadData()
    }
    
}
extension PlacesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let latitude:CLLocationDegrees =  Places.shared.landmarks?[indexPath.row].latidute ?? 0.0
        let longitude:CLLocationDegrees =  Places.shared.landmarks?[indexPath.row].longitude ?? 0.0
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
        
    }
}
