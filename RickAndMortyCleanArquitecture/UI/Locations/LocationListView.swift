//
//  LocationListView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct LocationListView: View {
    @ObservedObject private var viewModel: LocationListViewModel
    @State private var searchLocationText: String = ""

    init(viewModel: LocationListViewModel) {
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
                            ForEach(viewModel.filteredLocations, id: \.id) { location in
                                NavigationLink {
                                    
                                } label: {
                                    LocationListItemView(item: location)
                                }.onAppear {
                                    loadMoreLocationsIfNeeded(currentLocation: location)
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
                        .navigationTitle("Characters")
                        .accessibilityIdentifier("listCharacters")
                        
                    }
                    
                    .searchable(text: $searchLocationText).onChange(of: searchLocationText) { _, newValue in
                        //viewModel.search(searchText: newValue)
                    }.sheet(isPresented: $viewModel.isShowingFilters) {
                        //createFilterView
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear(isSearch: !searchLocationText.isEmpty)
        }
    }
    
    func loadMoreLocationsIfNeeded(currentLocation: LocationListPresentableItem) {
        Task {
            if currentLocation == viewModel.locations.last {
                viewModel.onAppear(isSearch: false)
            }
        }
    }
}

#Preview {
    LocationListFactory.create()
}
