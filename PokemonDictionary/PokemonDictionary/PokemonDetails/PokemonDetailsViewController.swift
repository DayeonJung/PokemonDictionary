//
//  PokemonDetailsViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/07.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var imageView: LoadingImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var locationsButton: UIButton!
    
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    let maxDimmedAlpha: CGFloat = 0.6
    var defaultHeight: CGFloat = 580
    let dismissibleHeight: CGFloat = 300

    var viewModel: PokemonDetailsViewModel! {
        didSet {
            self.viewModel.updateStackView = {
                DispatchQueue.main.async {
                    self.updateStackViewUI {
                        self.animate(onstraint: self.containerViewBottomConstraint,
                                     contant: 0)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        
        self.containerView.layer.cornerRadius = 16
        self.containerView.clipsToBounds = true
        self.dimmedView.alpha = self.maxDimmedAlpha

        self.setLocationButtonEvent()
        self.setTapGesture()
        self.setupPanGesture()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateShowDimmedView()
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animate(onstraint: NSLayoutConstraint!,
                         contant: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            onstraint.constant = contant
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateDismissView() {
        self.animate(onstraint: self.containerViewBottomConstraint,
                     contant: self.defaultHeight)
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    
    private func updateStackViewUI(completion: @escaping (() -> Void)) {
        guard let _ = self.stackView else { return }
        
        self.nameLabel.text = "이름 : " + self.viewModel.namesOfPokemon()
        self.heightLabel.text = "키 : " + self.viewModel.heightOfPokemon()
        self.weightLabel.text = "몸무게 : " + self.viewModel.weightOfPokemon()
        self.locationsButton.isHidden = !self.viewModel.hasHabitat()

        if let imageStr = self.viewModel.imageString() {
            self.imageView.loadImage(with: imageStr) {
                completion()
            }
        } else {
            self.imageView.isHidden = true
            completion()
        }

    }
    
}

extension PokemonDetailsViewController {
    
    private func setLocationButtonEvent() {
        self.locationsButton.addTarget(self, action: #selector(self.moveToMapVC),
                                       for: .touchUpInside)
    }
    
    @objc func moveToMapVC() {
        let destVC = PokemonMapViewController(nibName: "PokemonMapViewController", bundle: nil)
        destVC.viewModel = MapViewModel(locations: self.viewModel.locationInfos())
        self.present(destVC, animated: true, completion: nil)
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.handleTapGesture))
        self.dimmedView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        self.animateDismissView()
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        self.view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newHeight = self.defaultHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < self.defaultHeight {
                self.containerViewBottomConstraint?.constant = translation.y
                view.layoutIfNeeded()
            }
            
        case .ended:
            if newHeight < self.dismissibleHeight {
                self.animateDismissView()
            } else if newHeight < self.defaultHeight {
                self.animate(onstraint: self.containerViewBottomConstraint,
                             contant: 0)
            }
            
        default:
            break
        }
    }
}
