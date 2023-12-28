//
//  EpisodesListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct EpisodeListView: View {
    @ObservedObject private var viewModel: EpisodeListViewModel
    private let createEpisodeDetailView: CreateEpisodeDetailView

    init(viewModel: EpisodeListViewModel, createEpisodeDetailView: CreateEpisodeDetailView) {
        self.viewModel = viewModel
        self.createEpisodeDetailView = createEpisodeDetailView
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
                                    createEpisodeDetailView.create(episodeDetailInfo: episode)
                                } label: {
                                    EpisodesListItemView(item: episode)
                                }.onAppear {
                                    loadMoreEpisodesIfNeeded(currentEpisode: episode)
                                }
                            }
                        }
                        .navigationTitle("Episodes")
                        .accessibilityIdentifier("listEpisodes")

                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }

    func loadMoreEpisodesIfNeeded(currentEpisode: EpisodeListPresentableItem) {
        Task {
            if currentEpisode == viewModel.episodes.last {
                viewModel.onAppear()
            }
        }
    }
}

#Preview {
    EpisodeListFactory.create()
}
