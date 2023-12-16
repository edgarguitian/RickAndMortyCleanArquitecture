//
//  CharactersResultData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation
import SwiftData

@Model
class CharactersResultData {
    let info: InfoResultData?
    let result: [CharactersData]
    let currentPage: Int

    init(info: InfoResultData?, result: [CharactersData], currentPage: Int) {
        self.info = info
        self.result = result
        self.currentPage = currentPage
    }
}
