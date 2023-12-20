//
//  URLCache+imageCache.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
