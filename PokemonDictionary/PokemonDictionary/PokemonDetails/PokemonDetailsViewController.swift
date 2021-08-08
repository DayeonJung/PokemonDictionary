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
    
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    let maxDimmedAlpha: CGFloat = 0.6
    var defaultHeight: CGFloat = 580
    let dismissibleHeight: CGFloat = 200

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
        self.animatePresentContainer()
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        defaultHeight = self.stackView.bounds.height
    }
    
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        defaultHeight = height
    }
    
    private func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    
    func updateStackViewUI() {
        guard let _ = self.stackView else { return }
        
        self.nameLabel.text = "이름 : " + self.viewModel.namesOfPokemon()
        self.heightLabel.text = "키 : " + self.viewModel.heightOfPokemon()
        self.weightLabel.text = "몸무게 : " + self.viewModel.weightOfPokemon()
        self.locationsButton.isHidden = !self.viewModel.hasHabitat()

        if let imageStr = self.viewModel.imageString() {
            self.imageView.loadImage(with: imageStr) {
                let updatedStackViewHeight = self.stackView.bounds.height
                if self.defaultHeight != updatedStackViewHeight {
                    self.animateContainerHeight(updatedStackViewHeight)
                }
            }
        } else {
            self.imageView.isHidden = true
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
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        self.view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newHeight = defaultHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < defaultHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
            
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            } else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            
        default:
            break
        }
    }
}
