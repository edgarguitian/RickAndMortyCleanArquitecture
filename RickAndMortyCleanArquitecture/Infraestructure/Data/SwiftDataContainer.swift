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
            } else {
                context = nil
            }
        } catch {
            print("Error al crear el contenedor: \(error)")
            container = nil
            context = nil
        }
    }

    func fetchCharacters(currentPage: Int) -> CharactersResultData {
        let descriptor = FetchDescriptor<CharactersResultData>(predicate: #Predicate<CharactersResultData> { $0.currentPage == currentPage })

        guard let context = context, let characters = try? context.fetch(descriptor) else {
            return CharactersResultData(info: nil, result: [], currentPage: currentPage)
        }
        guard let charactersResult = characters.first else {
            return CharactersResultData(info: nil, result: [], currentPage: currentPage)
        }
        return charactersResult

    }

    func insert(_ charactersList: CharactersResultData) async {
        if let context = context {
            context.insert(charactersList)
            try? context.save()
        }
    }
}
