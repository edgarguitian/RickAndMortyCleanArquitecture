//
//  CacheCharacterDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol CacheCharacterDataSourceType {
    func getCharactersList() async -> CharacterResult
    func saveCharactersList(_ charactersList: CharacterResult, currentPage: Int) async
}
