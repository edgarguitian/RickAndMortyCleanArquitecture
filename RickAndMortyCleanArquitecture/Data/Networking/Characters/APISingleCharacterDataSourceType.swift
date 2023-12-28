//
//  APISingleCharacterDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol APISingleCharacterDataSourceType {
    func getSingleCharacter(characterId: String) async -> Result<CharacterListDTO, HTTPClientError>
    func getSingleCharacter(url: URL) async -> Result<CharacterListDTO, HTTPClientError>
}
