//
//  CharacterDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject private var viewModel: CharacterDetailViewModel
    private let createEpisodeDetailView: CreateEpisodeDetailView

    init(viewModel: CharacterDetailViewModel,
         createEpisodeDetailView: CreateEpisodeDetailView) {
        self.viewModel = viewModel
        self.createEpisodeDetailView = createEpisodeDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    List {
                        
                        CachedAsyncImage(url: URL(string: viewModel.characterDetailInfo.image), urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 300, height: 300)
                                            .clipShape(RoundedRectangle(cornerRadius: 35))
                                            .padding(.vertical)
                                    case .failure:
                                        // Handle failure, you might want to show an error view here
                                        AsyncImage(url: URL(string: viewModel.characterDetailInfo.image)) { image in
                                         image
                                         .resizable()
                                         .scaledToFill()
                                         .frame(width: 300, height: 300)
                                         } placeholder: {
                                         ProgressView()
                                         }
                                         .clipShape(RoundedRectangle(cornerRadius: 35))
                                         .padding(.vertical)
                                    }
                                }
                            
                        
                        Text(viewModel.characterDetailInfo.name)
                            .font(.title)
                        
                        Spacer()
                        
                        CharacterDetailItemView(title: "🟢 Status", value: viewModel.characterDetailInfo.status)
                        CharacterDetailItemView(title: "🧬 Species", value: viewModel.characterDetailInfo.species)
                        CharacterDetailItemView(title: "🌱 Type", value: viewModel.characterDetailInfo.type)
                        CharacterDetailItemView(title: "👤 Gender", value: viewModel.characterDetailInfo.gender)
                        CharacterDetailItemView(title: "📍 Origin", value: viewModel.characterDetailInfo.origin.name)
                        CharacterDetailItemView(title: "🗺 Location", value: viewModel.characterDetailInfo.location.name)
                        CharacterDetailItemView(title: "Created", value: viewModel.characterDetailInfo.created)
                        
                        Spacer()
                        
                        if viewModel.episodes.count > 0 {
                            Section(header:
                                        Text("Episodes (\(viewModel.episodes.count))")
                                .font(.title2)
                            ) {
                               
                                ForEach(viewModel.episodes, id: \.self) { episode in
                                    NavigationLink {
                                        createEpisodeDetailView.create(episodeDetailInfo: episode)
                                    } label: {
                                        VStack(alignment: .leading) {
                                            Text(episode.name)
                                                .font(.title3)
                                            Text(episode.episode)
                                                .font(.subheadline)
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    CharacterDetailFactory().create(characterId: "2")
}
