//
//  SearchCharactersListType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol SearchCharactersListType {
    func execute(searchText: String) async -> Result<[Character], RickAndMortyDomainError>
}
