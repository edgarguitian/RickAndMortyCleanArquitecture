//
//  EpisodeDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import SwiftUI

struct EpisodeDetailView: View {
    @ObservedObject private var viewModel: EpisodeDetailViewModel

    init(viewModel: EpisodeDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    ScrollView {
                        
                        Text(viewModel.episodeDetailInfo.name)
                            .font(.title)
                        
                        Spacer()
                        
                        CharacterDetailItemView(title: "📺 Episode", value: viewModel.episodeDetailInfo.episode)
                        CharacterDetailItemView(title: "📅 Air Date", value: viewModel.episodeDetailInfo.air_date)
                        CharacterDetailItemView(title: "Created", value: viewModel.episodeDetailInfo.created)
                        
                        Spacer()
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }
    }
}

#Preview {
    EpisodeDetailFactory().create(episodeDetailInfo: EpisodeListPresentableItem(id: "1", name: "Test Name 1", air_date: "September 10, 2017", episode: "S03E07", characters: [], url: "", created: "11-12-23 11:23"))
}
