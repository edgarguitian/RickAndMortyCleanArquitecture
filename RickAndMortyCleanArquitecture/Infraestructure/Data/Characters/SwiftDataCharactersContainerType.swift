//
//  SwiftDataContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol SwiftDataCharactersContainerType {
    func fetchCharacters() async -> [CharactersResultData]
    func insert(charactersResultList: CharactersResultData) async
    func insert(charactersDataList: CharactersData) async
    func insert(locationList: LocationCharacterData) async
    func insert(infoResultList: InfoResultCharactersData) async
    func saveData() async
}
