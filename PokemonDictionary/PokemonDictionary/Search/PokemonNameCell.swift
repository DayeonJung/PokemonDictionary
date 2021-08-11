//
//  PokemonNameCell.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import UIKit

class PokemonNameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }

}
