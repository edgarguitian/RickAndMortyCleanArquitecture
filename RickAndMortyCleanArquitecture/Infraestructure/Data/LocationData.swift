//
//  LocationData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation
import SwiftData

@Model
class LocationData {
    @Attribute(.unique) let identifier: UUID
    let name: String
    let url: String

    init(identifier: UUID = UUID(), name: String, url: String) {
        self.identifier = identifier
        self.name = name
        self.url = url
    }
}
