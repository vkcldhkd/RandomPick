//
//  RandomUserRepositoryImpl.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import Foundation
import RxSwift
import Alamofire

//https://randomuser.me/api/?results=20&gender=female&page=2

final class RandomUserRepositoryImpl: RandomUserRepository {
    private static let baseURL: String = "https://randomuser.me/api/?"
    private enum QueryItems {
        static let gender = "gender"
        static let page = "page"
        static let limit = "results"
    }
    
    func fetchRandomUsers(
        gender: RandomUserGender,
        page: Int = 1,
        limit: Int = 6
    ) -> Observable<NetworkResponse<RandomUserSearchResponse>?> {
        let queryItems: [URLQueryItem]? = RandomUserRepositoryImpl.createURLItems(
            gender: gender,
            page: page,
            limit: limit
        )
        
        let path: String = URLHelper.createAbsolutePath(
            baseURL: RandomUserRepositoryImpl.baseURL,
            queryItems: queryItems
        )
        
        return NetworkManager.requestDecodable(type: RandomUserSearchResponse.self, method: .get, url: path)
            .map { NetworkResponse(path: path, item: $0) }
    }
}

private extension RandomUserRepositoryImpl {
    static func createURLItems(
        gender: RandomUserGender,
        page: Int,
        limit: Int
    ) -> [URLQueryItem]? {
        return [
            URLQueryItem(name: QueryItems.gender, value: gender.rawValue.lowercased()),
            URLQueryItem(name: QueryItems.page, value: "\(page)"),
            URLQueryItem(name: QueryItems.limit, value: "\(limit)"),
        ]
    }
}
