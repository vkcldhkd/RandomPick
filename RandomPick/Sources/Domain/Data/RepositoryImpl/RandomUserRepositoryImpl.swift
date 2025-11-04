//
//  RandomUserRepositoryImpl.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import RxSwift

final class RandomUserRepositoryImpl: RandomUserRepository {
    func fetchRandomUsers(
        gender: RandomUserGender,
        page: Int,
        limit: Int
    ) -> Observable<[RandomUser]> {
        return RandomUserService.getRandomUser(gender: gender, page: page, limit: limit)
            .compactMap { $0?.data?.results }
            .map { response in
                response.map { RandomUser(gender: $0.gender, name: $0.name, picture: $0.picture) }
            }
    }
}
