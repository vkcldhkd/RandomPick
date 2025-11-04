//
//  RandomUserService.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import Foundation
import RxSwift
import Alamofire

//https://randomuser.me/api/?results=20&gender=female&page=2
struct RandomUserService {
    // MARK: - Constants
    private static let baseURL: String = "https://randomuser.me/api/?"
    private enum QueryItems {
        static let gender = "gender"
        static let page = "page"
        static let limit = "results"
    }
    
    static func getRandomUser(
        gender: RandomUserGender,
        page: Int = 1,
        limit: Int = 20
    ) -> Observable<NetworkResponse<RandomUserSearchResponse>?> {
        let queryItems: [URLQueryItem]? = RandomUserService.createURLItems(
            gender: gender,
            page: page,
            limit: limit
        )
        
        let path: String = URLHelper.createAbsolutePath(
            baseURL: RandomUserService.baseURL,
            queryItems: queryItems
        )
        
        return NetworkManager.requestDecodable(type: RandomUserSearchResponse.self, method: .get, url: path)
            .map { NetworkResponse(path: path, item: $0) }
    }
}

private extension RandomUserService {
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
