//
//  SignUpRequestModel.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

struct SignUpRequestModel{
    let fullName: String
    let email: String
    let password: String
}

extension SignUpRequestModel{
    var parameter: [String : String]{
        return [ "fullName" : self.fullName,
                 "email" : self.email,
                 "password": self.password
        ]
    }
}
