//
//  RandomUser.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import Foundation

// MARK: - Result
struct RandomUser: ModelType, Equatable {
    enum Event {
        case updateEditMode(isEditng: Bool)
        case select(user: RandomUser?, gender: RandomUserGender?)
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

