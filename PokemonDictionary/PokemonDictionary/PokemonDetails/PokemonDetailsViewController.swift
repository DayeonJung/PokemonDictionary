//
//  PokemonDetailsViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/07.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var imageView: LoadingImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var locationsButton: UIButton!
    
    var viewModel: PokemonDetailsViewModel! {
        didSet {
            self.viewModel.updateStackView = {
                DispatchQueue.main.async {
                    self.updateStackViewUI()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.alpha = 0
        
        self.locationsButton.addTarget(self, action: #selector(self.moveToMapVC), for: .touchUpInside)
    }


    @objc func moveToMapVC() {
        let destVC = PokemonMapViewController(nibName: "PokemonMapViewController", bundle: nil)
        destVC.viewModel = MapViewModel(locations: self.viewModel.locationInfos())
        self.present(destVC, animated: true, completion: nil)
    }
    
    func updateStackViewUI() {
        guard let stackView = self.stackView else { return }
        
        self.nameLabel.text = "이름 : " + self.viewModel.namesOfPokemon()
        self.heightLabel.text = "키 : " + self.viewModel.heightOfPokemon()
        self.weightLabel.text = "몸무게 : " + self.viewModel.weightOfPokemon()
        self.locationsButton.isHidden = !self.viewModel.hasHabitat()

        if let imageStr = self.viewModel.imageString() {
            self.imageView.loadImage(with: imageStr)
        } else {
            self.imageView.isHidden = true
        }
                
        UIView.animate(withDuration: 0.5) {
            stackView.alpha = 1
        }
    }
    
}
