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
        let scheme = Schema([CharactersResultData.self, CharactersData.self, LocationData.self, InfoResultData.self])
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
        
        
        do {
            guard let context = context else {
                return []
            }
            let characters = try context.fetch(descriptor)
            return characters
        } catch {
            print("Error al realizar la consulta: \(error)")
            return []
        }
        
        
    }
    
    func insert(charactersResultList: CharactersResultData) async {
        if let context = context {
            
            context.insert(charactersResultList)
            
            
        }
    }
    
    func insert(charactersDataList: CharactersData) async {
        if let context = context {
            
            context.insert(charactersDataList)
            
            
        }
    }
    
    func insert(locationList: LocationData) async {
        if let context = context {
            
            context.insert(locationList)
            
            
        }
    }
    
    func insert(infoResultList: InfoResultData) async {
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
