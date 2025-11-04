//
//  ProfileViewReactor.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import ReactorKit
import RxSwift

final class ProfileViewReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        var user: RandomUser
    }
    
    let initialState: State
    
    init(user: RandomUser) {
        defer { _ = self.state }
        self.initialState = State(user: user)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}

extension ProfileViewReactor: Equatable {
    static func == (lhs: ProfileViewReactor, rhs: ProfileViewReactor) -> Bool {
        return lhs.currentState.user == rhs.currentState.user
    }
}
