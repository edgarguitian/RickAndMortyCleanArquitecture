//
//  LocationListViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class LocationListViewModel: ObservableObject {
    private let getLocationList: GetAllLocationsList
    private let errorMapper: RickAndMortyPresentableErrorMapper
    private var currentPage: Int = 1
    private var lastPage: Int = -1
    @Published var filteredLocations: [LocationListPresentableItem] = []
    var locations: [LocationListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    
    init(getLocationList: GetAllLocationsList, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.getLocationList = getLocationList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        if currentPage == 1 {
            showLoadingSpinner = true
        }
        if(lastPage == -1 || lastPage > -1 && currentPage <= lastPage) {
            Task {
                let result = await getLocationList.execute(currentPage: currentPage)
                handleResult(result)
            }
        }
    }
    
    private func handleResult(_ result: Result<LocationResult, RickAndMortyDomainError>) {
        guard case .success(let locations) = result else {
            handleError(error: result.failureValue as? RickAndMortyDomainError)
            return
        }
        
        let locationsPresentable = locations.result.map {
            LocationListPresentableItem(id: String($0.id),
                                        name: $0.name,
                                        type: $0.type,
                                        dimension: $0.dimension,
                                        residents: $0.residents,
                                        url: $0.url,
                                        created: $0.created)
        }
        
        Task { @MainActor in
            
            showLoadingSpinner = false
            
            lastPage = locations.info.pages
            
            if lastPage > currentPage {
                if locations.info.count > locationsPresentable.count {
                    self.locations = self.locations + locationsPresentable
                    filteredLocations = self.locations
                    currentPage += 1
                } else {
                    currentPage = lastPage + 1
                    self.locations = locationsPresentable
                    filteredLocations = self.locations
                }
            } else {
                self.locations = self.locations + locationsPresentable
                filteredLocations = self.locations
            }
            
        }
    }
    
    private func handleError(error: RickAndMortyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
