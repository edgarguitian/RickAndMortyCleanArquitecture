//
//  SwiftDataContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol SwiftDataCharactersContainerType {
    func fetchCharacters() async -> [CharactersData]
    func fetchCharacters(page: Int) -> [CharactersData]
    func insert(charactersDataList: CharactersData) async
    func saveData() async
}
