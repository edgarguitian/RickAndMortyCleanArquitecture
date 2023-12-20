//
//  LocationDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import SwiftUI

struct LocationDetailView: View {
    @ObservedObject private var viewModel: LocationDetailViewModel
    
    init(viewModel: LocationDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    ScrollView {
                        
                        Text(viewModel.locationDetailInfo.name)
                            .font(.title)
                        
                        Spacer()
                        
                        CharacterDetailItemView(title: "🪐 Type", value: viewModel.locationDetailInfo.type)
                        CharacterDetailItemView(title: "✨ Dimension", value: viewModel.locationDetailInfo.dimension)
                        CharacterDetailItemView(title: "Created", value: viewModel.locationDetailInfo.created)
                        
                        Spacer()
                        
                        
                        Section(header:
                                    Text("Residents")
                            .font(.title2)
                        ) {
                            ForEach(viewModel.residents, id: \.self) { resident in
                                HStack {
                                    CachedAsyncImage(url: URL(string: resident.image), urlCache: .imageCache) { phase in
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
                                            AsyncImage(url: URL(string: resident.image)) { image in
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
                                    
                                    Text(resident.name)
                                        .font(.title3)
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
    LocationDetailFactory().create(locationDetailInfo: LocationListPresentableItem(id: "1", name: "Test Location", type: "Test Type", dimension: "Test Dimension", residents: [], url: "", created: "11-12-23 11:23"))
}
