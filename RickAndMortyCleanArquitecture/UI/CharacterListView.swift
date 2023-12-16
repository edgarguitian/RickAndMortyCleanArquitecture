//
//  CharacterListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject private var viewModel: CharacterListViewModel
    @State private var searchCharacterText: String = ""

    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    NavigationStack {
                        ScrollView {
                            ForEach(viewModel.characters, id: \.id) { character in
                                NavigationLink {
                                    
                                } label: {
                                    CharacterListItemView(item: character)
                                }.onAppear {
                                    loadMoreCharactersIfNeeded(currentCharacter: character)
                                }
                            }
                        }
                        .navigationTitle("Characters")
                        .accessibilityIdentifier("listCharacters")

                    }.searchable(text: $searchCharacterText).onChange(of: searchCharacterText) { _, newValue in
                        //viewModel.search(searchText: newValue)
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
    
    func loadMoreCharactersIfNeeded(currentCharacter: CharacterListPresentableItem) {
        Task {
            if currentCharacter == viewModel.characters.last {
                viewModel.onAppear()
            }
        }
    }
}

#Preview {
    CharacterListFactory.create()
}
