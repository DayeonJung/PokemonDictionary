//
//  Coorinate.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/08.
//

import MapKit
import UIKit

class Coorinate: NSObject, MKAnnotation {
    
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees

    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.latitude,
                                          longitude: self.longitude)
        }
        set {
            self.latitude = newValue.latitude
            self.longitude = newValue.longitude
        }
    }
    
    init(latitude: CLLocationDegrees,
         longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
}
