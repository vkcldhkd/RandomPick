//
//  LottoSpotlightCircleViewReactor.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import ReactorKit
import RxSwift

final class LottoSpotlightCircleViewReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setProfileItems([RandomUser])
        case setPagination(Pagination?)
    }
    
    struct State {
        var isLoading: Bool
        var profileItems: [RandomUser]
        var pagination: Pagination?
    }
    
    let initialState: State
    
    init() {
        defer { _ = self.state }
        self.initialState = State(isLoading: false, profileItems: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setLoading(isLoading):
            var newState = state
            newState.isLoading = isLoading
            return newState
            
        case let .setProfileItems(profileItems):
            var newState = state
            newState.profileItems = profileItems
            return newState
            
        case let .setPagination(pagination):
            var newState = state
            newState.pagination = pagination
            return newState
        }
    }
}
