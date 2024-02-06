//
//  LoginResponseModel.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

struct LoginResponseModel: Codable {
    let status: Bool?
    let message: String?
    let code: Int?
    let data: LoginResponseModelData?
}

struct LoginResponseModelData: Codable {
    let token: String?
    let user: UserData?
}

struct UserData: Codable {
    let id: Int?
    let firstName, lastName, email, phone: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, gender
    }
}

