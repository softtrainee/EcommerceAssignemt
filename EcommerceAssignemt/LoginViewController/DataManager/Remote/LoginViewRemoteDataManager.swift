//
//  LoginViewRemoteDataManager.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import Alamofire

class LoginViewRemoteDataManager: LoginViewRemoteDataManagerInputProtocol{
    var remoteRequestHandler: LoginViewRemoteDataManagerOutputProtocol?
    
    func postLoginRequest(loginModel: LoginRequestModel) {
        // Other error message need to be implemented, but later
        Alamofire
            .request(EndPoints.loginAPI.url, method: .post, parameters: loginModel.parameter)
            .validate()
            .responseLoginResponseModel { response in
                switch response.result{
                case .success(let loginResponseModel):
                    if let status = loginResponseModel.status, status{
                       if  let token = loginResponseModel.data?.token,
                        let user = loginResponseModel.data?.user{
                            self.remoteRequestHandler?.onSucessfulLogin(token: token, user: user)
                       }else{
                            self.remoteRequestHandler?.onError(message: "Could not fetch user information, please contact the support.")
                        }
                    }else{
                        if let statusMessage = loginResponseModel.message{
                            self.remoteRequestHandler?.onError(message: statusMessage)
                        }else{
                            self.remoteRequestHandler?.onError(message: "Something went wrong. Please try again later")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError(message: error.localizedDescription)
                }
        }
    }
}
