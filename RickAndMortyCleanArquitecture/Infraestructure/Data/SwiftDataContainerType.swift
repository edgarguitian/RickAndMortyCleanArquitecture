//
//  SwiftDataContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol SwiftDataContainerType {
    func fetchCharacters() async -> [CharactersResultData]
    func insert(charactersResultList: CharactersResultData) async
    func insert(charactersDataList: CharactersData) async
    func insert(locationList: LocationData) async 
    func insert(infoResultList: InfoResultData) async
    func saveData() async
}
