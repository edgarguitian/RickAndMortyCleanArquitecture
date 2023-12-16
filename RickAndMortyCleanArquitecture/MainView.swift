//
//  MainView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import SwiftUI

struct MainView: View {
    let characterList: CharacterListView
    var body: some View {
        TabView {
            characterList.tabItem {
                Label("Characters", systemImage: "person.3.fill")
            }
        }
    }
}
