//
//  CacheCharacterDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol CacheCharacterDataSourceType {
    func getCharactersList() async -> [Character]
    func saveCharactersList(_ charactersList: [Character]) async
}
