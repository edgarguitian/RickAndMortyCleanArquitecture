//
//  CharacterDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject private var viewModel: CharacterDetailViewModel

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    ScrollView {
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
