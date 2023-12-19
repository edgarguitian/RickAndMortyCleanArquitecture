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
                        
                        CharacterDetailItemView(title: "Type", value: viewModel.locationDetailInfo.type)
                        CharacterDetailItemView(title: "Dimension", value: viewModel.locationDetailInfo.dimension)
                        CharacterDetailItemView(title: "Created", value: viewModel.locationDetailInfo.created)
                        
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
    LocationDetailFactory().create(locationDetailInfo: LocationListPresentableItem(id: "1", name: "Test Location", type: "Test Type", dimension: "Test Dimension", residents: [], url: "", created: "11-12-23 11:23"))
}
