//
//  LoginViewPresenterProtocol.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

class LoginViewInteractor: LoginViewInteractorInputProtocol{
    
    var presenter: LoginViewInteractorOutputProtocol?
    var remoteDataManager: LoginViewRemoteDataManagerInputProtocol?
    var localDataManager: LoginViewLocalDataManagerInputProtocol?
    
    private func validUserCredentials(username: String, password: String) -> (status:Bool, message: String)  {
        let isUserNameValid = isValidUserName(username: username)
        let isPasswordValid = isValidPassword(password: password)
        
        if !isUserNameValid.status{
            return (isUserNameValid.status, isUserNameValid.message)
        }
        
        if !isPasswordValid.status{
            return(isPasswordValid.status, isPasswordValid.message)
        }
        
        return (true,"")
    }
    
    private func isValidUserName(username: String) -> (status:Bool, message: String) {
        if username.isEmpty{
            return (false, "Username cannot be empty.")
        }
        return (true, "")
    }
    
    private func isValidPassword(password: String) -> (status:Bool, message: String){
        if password.isEmpty{
            return (false,"Password cannot be empty")
        }
        
        if password.count < 6 {
            return (false,"Password should be 6 characters long.")
        }
        
        return (true, "" )
    }
    
    func postLoginRequest(username: String, password: String) {
        let validator = validUserCredentials(username: username, password: password)
        
        if validator.status{
            let loginRequestModel = LoginRequestModel(username: username, password: password)
            remoteDataManager?.postLoginRequest(loginModel: loginRequestModel)
        }else{
            onError(message: validator.message)
        }
    }
    
    static func isUserAlreadyLoggedIn() -> Bool {
        do{
            let user = try LoginViewLocalDataManager.reteriveUser()
            if let _ = user {
                return true
            }
        }catch(let data){
         print("error \(data)")
        }
        return false
    }
}

extension LoginViewInteractor: LoginViewRemoteDataManagerOutputProtocol{
    func onSucessfulLogin(token: String, user: UserData) {
        
        // Save the User in Core Data
        do{
            try localDataManager?.saveUser(token: token, userData: user)
            presenter?.didLoginCompleted()
        }catch(let data){
            
            print("Error: \(data)")
            presenter?.onError(message: "Something went wrong. Please try again.")
        }
    }
    
    func onError(message: String) {
       presenter?.onError(message: message)
    }
}
