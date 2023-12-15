//
//  GetAllCharactersListType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

protocol GetAllCharactersListType {
    func execute(currentPage: Int) async -> Result<[Character], RickAndMortyDomainError>
}
