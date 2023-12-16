//
//  AllCharactersListRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol AllCharactersListRepositoryType {
    func getAllCharactersList(currentPage: Int) async -> Result<CharacterResult, RickAndMortyDomainError>
}
