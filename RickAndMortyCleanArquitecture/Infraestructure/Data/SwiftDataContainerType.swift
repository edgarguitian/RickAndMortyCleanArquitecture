//
//  SwiftDataContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol SwiftDataContainerType {
    func fetchCharacters() -> [CharactersResultData]
    func insert(_ charactersList: CharactersResultData) async
}
