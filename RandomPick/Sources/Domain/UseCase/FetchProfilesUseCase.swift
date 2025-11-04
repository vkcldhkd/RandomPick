//
//  FetchProfilesUseCase.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import RxSwift

protocol FetchProfilesUseCase {
    func execute(
        gender: RandomUserGender,
        page: Int,
        limit: Int
    ) -> Observable<NetworkResponse<RandomUserSearchResponse>?>
}

final class DefaultFetchProfilesUseCase: FetchProfilesUseCase {
    private let repository: RandomUserRepository

    init(repository: RandomUserRepository) {
        self.repository = repository
    }

    func execute(
        gender: RandomUserGender,
        page: Int,
        limit: Int
    ) -> Observable<NetworkResponse<RandomUserSearchResponse>?> {
        return repository.fetchRandomUsers(gender: gender, page: page, limit: limit)
    }
}
