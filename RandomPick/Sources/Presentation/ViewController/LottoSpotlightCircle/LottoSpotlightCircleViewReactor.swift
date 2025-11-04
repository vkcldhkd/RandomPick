//
//  LottoSpotlightCircleViewReactor.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import ReactorKit
import RxSwift
import Dispatch

final class LottoSpotlightCircleViewReactor: Reactor {
    enum Action {
        case load
        case loadAnimationFinished
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setSpotlightActive(Bool)
        case setProfileResponse(RandomUserSearchResponse?)
        case setPagination(Pagination?)
    }
    
    struct State {
        var fetchProfilesUseCase: FetchProfilesUseCase
        
        var isLoading: Bool
        var isSpotlightActive: Bool
        var profileItems: [ProfileViewReactor]
        var pagination: Pagination?
        
    }
    
    let initialState: State
    
    init(fetchProfilesUseCase: FetchProfilesUseCase) {
        defer { _ = self.state }
        self.initialState = State(
            fetchProfilesUseCase: fetchProfilesUseCase,
            isLoading: false,
            isSpotlightActive: false,
            profileItems: []
            
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            let setProfileResponse = self.currentState.fetchProfilesUseCase.execute(gender: .male, page: 1, limit: 6)
                .map { Mutation.setProfileResponse($0?.data) }
            return Observable.concat([startLoading, setProfileResponse, endLoading])
            
        case .loadAnimationFinished:
            let setSpotlightActive = Observable.just(Mutation.setSpotlightActive(true))
            return Observable.concat([setSpotlightActive])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setLoading(isLoading):
            var newState = state
            newState.isLoading = isLoading
            return newState
            
        case let .setSpotlightActive(isSpotlightActive):
            var newState = state
            newState.isSpotlightActive = isSpotlightActive
            return newState
            
        case let .setProfileResponse(response):
            var newState = state
            newState.profileItems = self.createProfileItems(response: response)
            newState.pagination = PaginationHelper.check(
                pagination: Pagination(
                    lastPage: nil,
                    pagePerCount: response?.info?.results,
                    currentPage: response?.info?.page
                )
            )
            
            return newState
            
        case let .setPagination(pagination):
            var newState = state
            newState.pagination = pagination
            return newState
        }
    }
}


private extension LottoSpotlightCircleViewReactor {
    func createProfileItems(response: RandomUserSearchResponse?) -> [ProfileViewReactor] {
        return response?.results?.compactMap { ProfileViewReactor(user: $0) } ?? []
    }
}
