//
//  LoginRequestModel.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

struct LoginRequestModel{
    let username: String
    let password: String
}

extension LoginRequestModel{
    var parameter: [String : String] {
        return [ "username": self.username,
                 "password" : self.password
        ]
    }
}
