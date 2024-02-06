//
//  SignUpViewDataManager.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import Alamofire

class SignUpViewRemoteDataManager: SignUpRemoteDataManagerInputProtocol{
    var remoteRequestHandler: SignUpRemoteDataManagerOutputProtocol?
    
    func postSignUpRequest(signupModel: SignUpRequestModel) {
        Alamofire
            .request(EndPoints.signupAPI.url, method: .post, parameters: signupModel.parameter)
            .validate()
            .responseSignUpResponseModel{ response in
                switch response.result{
                case .success(let signupResponseModel):
                    if let status = signupResponseModel.status, status{
                        if  let token = signupResponseModel.data?.token,
                            let user = signupResponseModel.data?.user{
                                self.remoteRequestHandler?.onSucessfulSignUp(token: token, user: user)
                        }else{
                            self.remoteRequestHandler?.onError(message: "Could not fetch user information, please contact the support.")
                        }
                    }else{
                        if let statusMessage = signupResponseModel.message{
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
