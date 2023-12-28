//
//  LocationsData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

@Model
class LocationsData {
    @Attribute(.unique) let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    let page: Int
    let numPages: Int
    let count: Int

    init(id: Int, name: String, type: String, dimension: String, residents: [String], url: String, created: String, page: Int, numPages: Int, count: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = created
        self.page = page
        self.numPages = numPages
        self.count = count
    }
}
