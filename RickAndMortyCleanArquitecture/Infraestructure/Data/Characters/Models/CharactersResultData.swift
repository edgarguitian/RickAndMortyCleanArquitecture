//
//  CharactersResultData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation
import SwiftData

@Model
final class CharactersResultData {
    @Relationship(deleteRule: .cascade, inverse: \InfoResultCharactersData.infoResultData) let info: [InfoResultCharactersData]
    @Relationship(deleteRule: .cascade, inverse: \CharactersData.charactersResultData) var result: [CharactersData]
    @Attribute(.unique) let currentPage: Int

    init(info: [InfoResultCharactersData], result: [CharactersData] = [], currentPage: Int) {
        self.info = info
        self.result = result
        self.currentPage = currentPage
    }
}
