//
//  Endpoint.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String: Any]
    let method: HTTPMethod
}
