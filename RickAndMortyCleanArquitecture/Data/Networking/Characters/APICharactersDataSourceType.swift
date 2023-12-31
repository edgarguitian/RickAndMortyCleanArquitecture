//
//  APICharactersDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol APICharactersDataSourceType {
    func getCharactersList(currentPage: Int) async -> Result<CharacterResponseDTO, HTTPClientError>
}
