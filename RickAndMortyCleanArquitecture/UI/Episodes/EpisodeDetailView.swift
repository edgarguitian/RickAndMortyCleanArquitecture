//
//  EpisodeDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import SwiftUI

struct EpisodeDetailView: View {
    @ObservedObject private var viewModel: EpisodeDetailViewModel
    private let createCharacterDetailView: CreateCharacterDetailView

    init(viewModel: EpisodeDetailViewModel,
         createCharacterDetailView: CreateCharacterDetailView) {
        self.viewModel = viewModel
        self.createCharacterDetailView = createCharacterDetailView

    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    List {
                        Section(header: Text("INFO")
                                            .font(.title2)
                        ) {
                            CharacterDetailItemView(title: "📺 Episode", value: viewModel.episodeDetailInfo.episode)
                            CharacterDetailItemView(title: "📅 Air Date", value: viewModel.episodeDetailInfo.air_date)
                            // CharacterDetailItemView(title: "Created", value: viewModel.episodeDetailInfo.created)
                        }
                        
                        if viewModel.characters.count > 0 {
                            Section(header:
                                        Text("CHARACTERS")
                                            .font(.title2)
                            ) {
                                ForEach(viewModel.characters, id: \.self) { character in
                                    NavigationLink {
                                        createCharacterDetailView.create(characterId: character.id)
                                    } label: {
                                        HStack {
                                            CachedAsyncImage(url: URL(string: character.image), urlCache: .imageCache) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 30, height: 30)
                                                        .clipShape(RoundedRectangle(cornerRadius: 35))
                                                        .padding(.vertical)
                                                case .failure:
                                                    // Handle failure, you might want to show an error view here
                                                    AsyncImage(url: URL(string: character.image)) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 30, height: 30)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 35))
                                                    .padding(.vertical)
                                                }
                                            }
                                            
                                            Text(character.name)
                                                .font(.title3)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }
        .navigationTitle(viewModel.episodeDetailInfo.name)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    EpisodeDetailFactory().create(episodeDetailInfo: EpisodeListPresentableItem(id: "1", name: "Test Name 1", air_date: "September 10, 2017", episode: "S03E07", characters: [], url: "", created: "11-12-23 11:23"))
}
