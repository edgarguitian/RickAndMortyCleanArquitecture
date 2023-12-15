//
//  RickAndMortyCleanArquitectureApp.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import SwiftUI

@main
struct RickAndMortyCleanArquitectureApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(characterList: CharacterListFactory.create())
        }
    }
}
