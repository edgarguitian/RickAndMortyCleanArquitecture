//
//  EpisodesListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct EpisodeListView: View {
    @ObservedObject private var viewModel: EpisodeListViewModel
    @State private var searchEpisodeText: String = ""

    init(viewModel: EpisodeListViewModel) {
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
                            ForEach(viewModel.filteredEpisodes, id: \.id) { episode in
                                NavigationLink {
                                    
                                } label: {
                                    EpisodesListItemView(item: episode)
                                }.onAppear {
                                    loadMoreEpisodesIfNeeded(currentEpisode: episode)
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
                        .navigationTitle("Episodes")
                        .accessibilityIdentifier("listEpisodes")
                        
                    }
                    
                    .searchable(text: $searchEpisodeText).onChange(of: searchEpisodeText) { _, newValue in
                        //viewModel.search(searchText: newValue)
                    }.sheet(isPresented: $viewModel.isShowingFilters) {
                        //createFilterView
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear(isSearch: !searchEpisodeText.isEmpty)
        }
    }
    
    func loadMoreEpisodesIfNeeded(currentEpisode: EpisodeListPresentableItem) {
        Task {
            if currentEpisode == viewModel.episodes.last {
                viewModel.onAppear(isSearch: false)
            }
        }
    }
}

#Preview {
    EpisodeListFactory.create()
}

