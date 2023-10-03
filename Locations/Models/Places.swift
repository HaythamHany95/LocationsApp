//
//  Places.swift
//  Locations
//
//  Created by Haytham on 03/10/2023.
//

import Foundation
import RealmSwift

class Places {
    static let shared = Places()
    
    var landmarks: Results<Landmark>?
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
}
