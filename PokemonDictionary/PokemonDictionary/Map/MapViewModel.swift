//
//  MapViewModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/08.
//

import Foundation
import MapKit

struct MapViewModel {
    
    let coordinates: [Coorinate]
    private let centerCoordi: CLLocationCoordinate2D
    private let maxDistance: CLLocationDistance?
    
    var region: MKCoordinateRegion {
        guard let maxDistance = self.maxDistance else {
            return MKCoordinateRegion()
        }
        return MKCoordinateRegion(center: self.centerCoordi,
                                  latitudinalMeters: maxDistance,
                                  longitudinalMeters: maxDistance)
    }
    
    init(locations: [(Double, Double)]) {
        
        self.coordinates = locations.map({Coorinate(latitude: $0.0, longitude: $0.1)})

        let centerLat = locations.map({$0.0}).reduce(0, +)/Double(locations.count)
        let centerLng = locations.map({$0.1}).reduce(0, +)/Double(locations.count)
        self.centerCoordi = CLLocationCoordinate2D(latitude: centerLat,
                                                   longitude: centerLng)
        
        let centerLocation = CLLocation(latitude: centerLat,
                                        longitude: centerLng)
        let clLocations = locations.map({ CLLocation(latitude: $0.0,
                                                     longitude: $0.1) })
        let maxDistance = clLocations.map({ $0.distance(from: centerLocation) }).max()
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let ratio = width > height ? width / height : height / width
        self.maxDistance = maxDistance.map({ $0 * Double(ratio) })
        
    }
    
}
