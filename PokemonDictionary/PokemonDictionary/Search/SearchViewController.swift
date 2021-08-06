//
//  SearchViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/05.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchList: UICollectionView!
    
    var viewModel: SearchViewModel! {
        didSet {
            self.viewModel.updateList = {
                print("update")
                self.searchList.reloadData()
            }
        }
    }
    
    var inputTopView: InputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SearchViewModel()

        self.inputTopView = InputView(frame: CGRect(origin: .zero,
                                                size: CGSize(width: UIScreen.main.bounds.width, height: 70)))
        self.view.addSubview(self.inputTopView)
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

extension SearchViewController: UICollectionViewDelegateFlowLayout {

}

extension SearchViewController: UICollectionViewDelegate {
    
}

