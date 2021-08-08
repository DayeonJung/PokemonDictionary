//
//  PokemonAnnotationView.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/08.
//

import MapKit

class PokemonAnnotationView: MKMarkerAnnotationView {
    
    static let reuseID = "pokemonAnnotation"
    
    override init(annotation: MKAnnotation?,
                  reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "pokemon"
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        markerTintColor = .systemYellow
        
        if let cluster = annotation as? MKClusterAnnotation {
            let total = cluster.memberAnnotations.count
            glyphText = "\(total)"
        } else {
            glyphText = "1"
        }
        
    }
    

}
