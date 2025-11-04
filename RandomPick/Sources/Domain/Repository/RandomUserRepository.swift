//
//  RandomUserRepository.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import RxSwift

protocol RandomUserRepository {
    func fetchRandomUsers(
        gender: RandomUserGender,
        page: Int,
        limit: Int
    ) -> Observable<[RandomUser]>
}
