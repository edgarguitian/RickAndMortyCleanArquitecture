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
    @Attribute(.unique) let id: UUID
    let info: InfoResultData?
    let result: [CharactersData]
    let currentPage: Int

    init(id: UUID = UUID(), info: InfoResultData?, result: [CharactersData] = [], currentPage: Int) {
        self.id = id
        self.info = info
        self.result = result
        self.currentPage = currentPage
    }
}
