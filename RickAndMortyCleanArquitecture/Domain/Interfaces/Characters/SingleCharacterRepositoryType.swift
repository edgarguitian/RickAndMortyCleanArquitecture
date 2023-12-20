//
//  SingleCharacterRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol SingleCharacterRepositoryType {
    func getSingleCharacter(characterId: String) async -> Result<Character, RickAndMortyDomainError>
    func getSingleCharacter(url: URL) async -> Result<Character, RickAndMortyDomainError>
}
