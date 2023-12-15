//
//  CharacterListPresentableItem.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

struct CharacterListPresentableItem {
    let id: String
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}

extension CharacterListPresentableItem: Hashable {

}
