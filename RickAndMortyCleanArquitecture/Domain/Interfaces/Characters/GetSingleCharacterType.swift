//
//  GetSingleCharacterType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol GetSingleCharacterType {
    func execute(characterId: String) async -> Result<Character, RickAndMortyDomainError>
    func execute(url: URL) async -> Result<Character, RickAndMortyDomainError>
}
