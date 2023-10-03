//
//  Landmark.swift
//  Locations
//
//  Created by Haytham on 03/10/2023.
//

import Foundation
import RealmSwift

class Landmark: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var latidute: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var time: Date = Date()
    
}

