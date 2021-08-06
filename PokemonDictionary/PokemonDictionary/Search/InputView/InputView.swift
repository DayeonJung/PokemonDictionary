//
//  InputView.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation
import UIKit

protocol InputDelegate {
    func updateInput(with model: Input)
}

class InputView: UIView {
    
    @IBOutlet weak var textField: UITextField!
    var delegate: InputDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    private func commoninit() {
        let bundle = Bundle(for: InputView.self)
        let superView = bundle.loadNibNamed("InputView", owner: self, options: nil)?.first as! UIView
        self.addSubview(superView)
        superView.frame = self.bounds
        superView.layoutIfNeeded()
        
        self.textField.addTarget(self,
                                 action: #selector(textFieldDidChange(_:)),
                                 for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              !text.isEmpty else { return }
        let input = Input(text: text)
        self.delegate?.updateInput(with: input)
    }
}
