//
//  CharacterListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject private var viewModel: CharacterListViewModel
    private let createCharacterDetailView: CreateCharacterDetailView
    private let createFilterView: FilterView

    @State private var searchCharacterText: String = ""
    
    
    init(viewModel: CharacterListViewModel, createCharacterDetailView: CreateCharacterDetailView, createFilterView: FilterView) {
        self.viewModel = viewModel
        self.createCharacterDetailView = createCharacterDetailView
        self.createFilterView = createFilterView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    NavigationStack {
                        ScrollView {
                            ForEach(viewModel.filteredCharacters, id: \.id) { character in
                                NavigationLink {
                                    createCharacterDetailView.create(characterId: character.id)
                                } label: {
                                    CharacterListItemView(item: character)
                                }.onAppear {
                                    loadMoreCharactersIfNeeded(currentCharacter: character)
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) { // Boton de filtros
                                Button {
                                    viewModel.isShowingFilters.toggle()
                                } label: {
                                    Image(systemName: "slider.horizontal.3")
                                }
                            }
                        }
                        .onChange(of: viewModel.selectedStatusIndex) { _, _ in
                            viewModel.filterCharacters()
                        }
                        .onChange(of: viewModel.selectedStatusIndex) { _, _ in
                            viewModel.filterCharacters()
                        }
                        .navigationTitle("Characters")
                        .accessibilityIdentifier("listCharacters")
                        
                    }
                    
                    .searchable(text: $searchCharacterText).onChange(of: searchCharacterText) { _, newValue in
                        viewModel.search(searchText: newValue)
                    }.sheet(isPresented: $viewModel.isShowingFilters) {
                        createFilterView
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear(isSearch: !searchCharacterText.isEmpty)
        }
    }
    
    func loadMoreCharactersIfNeeded(currentCharacter: CharacterListPresentableItem) {
        Task {
            if currentCharacter == viewModel.characters.last {
                viewModel.onAppear(isSearch: false)
            }
        }
    }
}

#Preview {
    CharacterListFactory.create()
}
