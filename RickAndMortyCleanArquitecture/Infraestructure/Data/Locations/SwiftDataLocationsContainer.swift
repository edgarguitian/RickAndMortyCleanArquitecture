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
        let scheme = Schema([LocationsResultData.self, LocationsData.self, InfoResultLocationsData.self])
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
    
    func fetchLocations() -> [LocationsResultData] {
        let descriptor = FetchDescriptor<LocationsResultData>()
        
        
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
    
    func insert(locationsResultList: LocationsResultData) async {
        if let context = context {
            
            context.insert(locationsResultList)
            
            
        }
    }
    
    func insert(locationsDataList: LocationsData) async {
        if let context = context {
            
            context.insert(locationsDataList)
            
            
        }
    }
    
    func insert(infoResultList: InfoResultLocationsData) async {
        if let context = context {
            
            context.insert(infoResultList)
            
            
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
