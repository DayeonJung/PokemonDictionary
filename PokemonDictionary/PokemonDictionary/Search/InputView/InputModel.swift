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
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let results = regex.matches(in: String(text), options: [], range: NSRange(location: 0, length: 1))
            return results.count == 0 ? .English : .Korean

        }
        return .English
    }
}
