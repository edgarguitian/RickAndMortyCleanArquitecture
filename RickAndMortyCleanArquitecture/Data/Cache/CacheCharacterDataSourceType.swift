//
//  CacheCharacterDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol CacheCharacterDataSourceType {
    func getCharactersList(currentPage: Int) async -> CharacterResult
    func saveCharactersList(_ charactersList: CharacterResult) async
}
