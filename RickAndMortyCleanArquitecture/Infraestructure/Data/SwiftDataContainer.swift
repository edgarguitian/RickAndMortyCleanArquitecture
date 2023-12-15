//
//  SwiftDataContainer.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation
import SwiftData

class SwiftDataContainer: SwiftDataContainerType {
    static let shared = SwiftDataContainer()

    private let container: ModelContainer?
    private let context: ModelContext?

    private init() {
        let scheme = Schema([CharactersData.self])
        do {
            container = try ModelContainer(for: scheme, configurations: [])
            if let container = container {
                context = ModelContext(container)
            } else {
                context = nil
            }
        } catch {
            print("Error al crear el contenedor: \(error)")
            container = nil
            context = nil
        }
    }

    func fetchCharacters() -> [CharactersData] {
        let descriptor = FetchDescriptor<CharactersData>()

        guard let context = context, let characters = try? context.fetch(descriptor) else {
            return []
        }

        return characters
    }

    func insert(_ charactersList: [CharactersData]) async {
        if let context = context {
            charactersList.forEach { character in
                context.insert(character)
            }

            try? context.save()
        }
    }
}
