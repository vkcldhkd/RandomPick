//
//  RandomUser.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import Foundation

// MARK: - Result
struct RandomUser: Codable, Equatable {
    static func == (lhs: RandomUser, rhs: RandomUser) -> Bool {
        return lhs.createName() == rhs.createName() && lhs.gender == rhs.gender   
    }
    
    let gender: RandomUserGender?
    let name: RandomUserName?
    let location: RandomUserLocation?
    let email: String?
    let login: RandomUserLoginInfo?
    let dob, registered: RandomUserDob?
    let phone, cell: String?
    let id: RandomUserID?
    let picture: RandomUserPicture?
    let nat: String?
    
    init(
        gender: RandomUserGender?,
        name: RandomUserName?,
        picture: RandomUserPicture?
    ) {
        self.gender = gender
        self.name = name
        self.picture = picture
        // 나머지 프로퍼티들은 nil 기본값으로 설정
        self.location = nil
        self.email = nil
        self.login = nil
        self.dob = nil
        self.registered = nil
        self.phone = nil
        self.cell = nil
        self.id = nil
        self.nat = nil
    }
}

extension RandomUser {
    func createName() -> String {
        let firstName = self.name?.first ?? ""
        let lastName = self.name?.last ?? ""
        return firstName + " " + lastName
    }
}
