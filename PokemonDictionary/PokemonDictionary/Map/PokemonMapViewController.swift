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

        self.mapView.delegate = self
        self.mapView.register(PokemonAnnotationView.self,
                              forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        self.setMapView()

    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setMapView() {
        self.mapView.setRegion(self.viewModel.region, animated: true)
        self.mapView.addAnnotations(self.viewModel.coordinates)
    }
    
}

extension PokemonMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return PokemonAnnotationView(annotation: annotation,
                                     reuseIdentifier: PokemonAnnotationView.reuseID)
    }
}
