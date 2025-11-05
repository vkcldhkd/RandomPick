//
//  ProfileDetailViewReactor.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/6/25.
//

import ReactorKit
import RxSwift

final class ProfileDetailViewReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        var profile: RandomUser
    }
    
    let initialState: State
    
    init(profile: RandomUser) {
        defer { _ = self.state }
        self.initialState = State(profile: profile)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
