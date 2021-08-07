//
//  PokemonDetailsViewController.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/07.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    var viewModel: PokemonDetailsViewModel! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(viewModel)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
