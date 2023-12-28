//
//  EpisodeListFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class EpisodeListFactory {

    static func create() -> EpisodeListView {
        return EpisodeListView(viewModel: createViewModel(), createEpisodeDetailView: EpisodeDetailFactory())
    }

    private static func createViewModel() -> EpisodeListViewModel {
        return EpisodeListViewModel(getEpisodeList: createGetAllEpisodesListUseCase(),
                                     errorMapper: RickAndMortyPresentableErrorMapper())
    }

    private static func createGetAllEpisodesListUseCase() -> GetAllEpisodesList {
        return GetAllEpisodesList(repository: createRepository())
    }

    private static func createRepository() -> AllEpisodesListRepository {
        return AllEpisodesListRepository(apiDataSource: createAPIDataSource(),
                                         errorMapper: RickAndMortyDomainErrorMapper(),
                                         cacheDataSource: createCacheDataSource())
    }

    static func createCacheDataSource() -> CacheEpisodesDataSourceType {
        return SwiftDataCacheEpisodesDataSource(container: SwiftDataEpisodesContainer.shared,
                                                mapper: SwiftDataEpisodesDomainMapper())
    }

    private static func createAPIDataSource() -> APIEpisodesDataSourceType {
        return APIEpisodesDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
