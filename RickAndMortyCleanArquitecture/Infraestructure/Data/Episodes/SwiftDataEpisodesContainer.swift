//
//  SwiftDataEpisodesContainer.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

class SwiftDataEpisodesContainer: SwiftDataEpisodesContainerType {

    static let shared = SwiftDataEpisodesContainer()
    
    private let container: ModelContainer?
    private let context: ModelContext?
    
    private init() {
        let scheme = Schema([EpisodesResultData.self, EpisodesData.self, InfoResultEpisodesData.self])
        do {
            let storeURL = URL.documentsDirectory.appending(path: "dbEpisodes.sqlite")
            let config = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: scheme, configurations: config)
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
    
    func fetchEpisodes() -> [EpisodesResultData] {
        let descriptor = FetchDescriptor<EpisodesResultData>()
        
        
        do {
            guard let context = context else {
                return []
            }
            let episodes = try context.fetch(descriptor)
            return episodes
        } catch {
            print("Error al realizar la consulta: \(error)")
            return []
        }
        
    }
    
    func insert(episodesResultList: EpisodesResultData) async {
        if let context = context {
            
            context.insert(episodesResultList)
            
            
        }
    }
    
    func insert(episodesDataList: EpisodesData) async {
        if let context = context {
            
            context.insert(episodesDataList)
            
            
        }
    }
    
    func insert(infoResultList: InfoResultEpisodesData) async {
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
