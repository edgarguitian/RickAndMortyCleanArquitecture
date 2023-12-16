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
        let scheme = Schema([CharactersResultData.self])
        do {
            container = try ModelContainer(for: scheme, configurations: [])
            if let container = container {
                context = ModelContext(container)
                context?.autosaveEnabled = true
            } else {
                context = nil
            }
        } catch {
            print("Error al crear el contenedor: \(error)")
            container = nil
            context = nil
        }
    }

    func fetchCharacters() -> [CharactersResultData] {
        let descriptor = FetchDescriptor<CharactersResultData>()

        guard let context = context, let characters = try? context.fetch(descriptor) else {
            return []
        }
        
        return characters

    }

    func insert(_ charactersList: CharactersResultData) async {
        if let context = context {
            context.insert(charactersList)
            if let infoResultData = charactersList.info {
                context.insert(infoResultData)
            }
            for result in charactersList.result {
                context.insert(result)
            }
            do {
                try context.save()
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
