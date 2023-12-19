//
//  LocationListPresentableItem.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct LocationListPresentableItem {
    let id: String
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    init(id: String, name: String, type: String, dimension: String, residents: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = DateFormatterUtils.formatDate(created)
    }
}

extension LocationListPresentableItem: Hashable {

}
