//
//  SwiftDataLocationsContainer.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

class SwiftDataLocationsContainer: SwiftDataLocationsContainerType {

    static let shared = SwiftDataLocationsContainer()

    private let container: ModelContainer?
    private let context: ModelContext?

    private init() {
        let scheme = Schema([LocationsData.self])
        do {
            let storeURL = URL.documentsDirectory.appending(path: "dbLocations.sqlite")
            let config = ModelConfiguration(url: storeURL)
            let configMemory = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: scheme, configurations: [config, configMemory])
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

    func fetchLocations() -> [LocationsData] {
        let descriptor = FetchDescriptor<LocationsData>()

        do {
            guard let context = context else {
                return []
            }
            let locations = try context.fetch(descriptor)
            return locations
        } catch {
            print("Error al realizar la consulta: \(error)")
            return []
        }

    }
    
    func fetchLocations(page: Int) -> [LocationsData] {
        let descriptor = FetchDescriptor<LocationsData>(predicate: #Predicate { location in
            location.page == page
        })

        do {
            guard let context = context else {
                return []
            }
            let locations = try context.fetch(descriptor)
            return locations
        } catch {
            print("Error al realizar la consulta: \(error)")
            return []
        }
    }

    func insert(locationsDataList: LocationsData) async {
        if let context = context {
            context.insert(locationsDataList)
        }
    }

    func saveData() async {
        if let context = context {
            do {
                try context.save()
            } catch {
                print("Error saveData \(error.localizedDescription)")
            }
        }
    }

}
