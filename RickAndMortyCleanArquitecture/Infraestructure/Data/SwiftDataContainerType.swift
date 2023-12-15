//
//  SwiftDataContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol SwiftDataContainerType {
    func fetchCharacters() -> [CharactersData]
    func insert(_ charactersList: [CharactersData]) async
}
