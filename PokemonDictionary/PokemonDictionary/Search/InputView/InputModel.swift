//
//  InputModel.swift
//  PokemonDictionary
//
//  Created by Dayeon Jung on 2021/08/06.
//

import Foundation

protocol InputGettable {
    var text: String { get }
    var languageType: Language { get set }
}

enum Language: Int {
    case Korean = 0
    case English = 1
}

struct Input: InputGettable {
    
    var text: String
    var languageType: Language = .English
    
    init(text: String) {
        self.text = text
        self.languageType = self.checkLanguage()
        
    }
    
    private func checkLanguage() -> Language {
        guard let text = self.text.first else { return .English }
        
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣ]$"
        let textStr = String(text)
        let firstLetterRange = textStr.startIndex..<textStr.index(after: textStr.startIndex)
        
        if let _ = textStr.range(of: pattern,
                              options: .regularExpression,
                              range: firstLetterRange,
                              locale: nil) {
            return .Korean
        }

        return .English

    }
}
