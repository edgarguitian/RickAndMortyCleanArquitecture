//
//  LocationListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct LocationListView: View {
    @ObservedObject private var viewModel: LocationListViewModel
    private let createLocationDetailView: CreateLocationDetailView

    init(viewModel: LocationListViewModel, createLocationDetailView: CreateLocationDetailView) {
        self.viewModel = viewModel
        self.createLocationDetailView = createLocationDetailView
    }

    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                LoadingSpinnerView()
            } else {
                if viewModel.showErrorMessage == nil {
                    NavigationStack {
                        ScrollView {
                            ForEach(viewModel.filteredLocations, id: \.id) { location in
                                NavigationLink {
                                    createLocationDetailView.create(locationDetailInfo: location)
                                } label: {
                                    LocationListItemView(item: location)
                                }.onAppear {
                                    loadMoreLocationsIfNeeded(currentLocation: location)
                                }
                            }
                        }
                        .navigationTitle("Locations")
                        .accessibilityIdentifier("listLocations")

                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }

    func loadMoreLocationsIfNeeded(currentLocation: LocationListPresentableItem) {
        Task {
            if currentLocation == viewModel.locations.last {
                viewModel.onAppear()
            }
        }
    }
}

#Preview {
    LocationListFactory.create()
}
