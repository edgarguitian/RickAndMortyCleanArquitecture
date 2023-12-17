//
//  SearchCharactersListRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol SearchCharactersListRepositoryType {
    func search(searchText: String) async -> Result<[Character], RickAndMortyDomainError>
}
