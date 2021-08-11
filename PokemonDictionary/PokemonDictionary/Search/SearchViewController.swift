//
//  SearchViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var inputTopView: InputView!
    @IBOutlet weak var searchList: UICollectionView!
    
    var viewModel: SearchViewModel! {
        didSet {
            self.viewModel.updateList = {
                self.searchList.reloadData()
            }
            
            self.viewModel.moveToDestinationVC = { viewModel in
                let destVC = PokemonDetailsViewController(nibName: "PokemonDetailsViewController", bundle: nil)
                destVC.viewModel = viewModel
                destVC.modalPresentationStyle = .overCurrentContext
                self.present(destVC, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.viewModel = SearchViewModel()
        self.inputTopView.delegate = self.viewModel
        self.searchList.setCell(cellName: PokemonNameCell.self)
    }


}


extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfSearched()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.loadCell(identifier: PokemonNameCell.self, indexPath: indexPath)
        cell.titleLabel.text = self.viewModel.nameOfSearchedPokemon(at: indexPath.item)
        return cell
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItem(at: indexPath.item)
    }
}

