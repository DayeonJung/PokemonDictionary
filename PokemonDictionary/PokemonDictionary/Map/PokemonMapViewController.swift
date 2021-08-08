//
//  PokemonMapViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/08.
//

import UIKit
import MapKit

class PokemonMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var viewModel: MapViewModel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMapView(coordinates: self.viewModel.coordinate)

    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setMapView(coordinates: [CLLocationCoordinate2D]) {
        
        guard let maxDistance = self.viewModel.maxDistance else { return }
        let region = MKCoordinateRegion(center: self.viewModel.centerCoordi,
                                        latitudinalMeters: maxDistance,
                                        longitudinalMeters: maxDistance)
        self.mapView.setRegion(region, animated: true)
        
        _ = coordinates.map({
            self.addAnnotation(coordinate: $0)
        })
        
    }
    
    
    private func addAnnotation(coordinate: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
    }
    
    
    
}
