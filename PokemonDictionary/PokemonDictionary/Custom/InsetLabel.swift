//
//  InsetLabel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/10.
//

import UIKit

@IBDesignable
class InsetLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 12
    @IBInspectable var bottomInset: CGFloat = 12
    @IBInspectable var leftInset: CGFloat = 12
    @IBInspectable var rightInset: CGFloat = 12
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset,
                                       left: leftInset,
                                       bottom: bottomInset,
                                       right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
