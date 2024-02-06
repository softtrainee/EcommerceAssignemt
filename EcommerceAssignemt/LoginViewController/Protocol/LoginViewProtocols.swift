//
//  LoginViewProtocols.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject{
    var presenter: LoginViewPresenterProtocol? { get set }
    
    //Presenter -> View
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol LoginViewPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginViewInteractorInputProtocol? {get set}
    var wireFrame: LoginViewWireFrameProtocol? {get set}
    
    //View -> Presenter
    func viewDidLoad()
    func forgetPassword()
    func signup()
    func signIn(username: String, password: String)
    func routeToHomeScreen()
    func showAlert(message: String)
}

protocol LoginViewInteractorInputProtocol: AnyObject{
    var presenter: LoginViewInteractorOutputProtocol? {get set}
    var remoteDataManager: LoginViewRemoteDataManagerInputProtocol? { get set }
    var localDataManager: LoginViewLocalDataManagerInputProtocol? { get set }
    
    //Presenter -> Intractor
    func postLoginRequest(username: String, password: String)
    
    static func isUserAlreadyLoggedIn() -> Bool
}

protocol LoginViewInteractorOutputProtocol: AnyObject{
    
    // Intractor -> Presenter
    func didLoginCompleted()
    func onError(message: String)
}

protocol LoginViewWireFrameProtocol: AnyObject{
    
    var delegate: LoginViewDelegateProtocol? { get set }
    
    static func createLoginViewModule(delegate: LoginViewDelegateProtocol?) -> UIViewController
    
    //Presenter -> WireFrame
    func presentHomeScreen(from view: LoginViewProtocol)
    func presentForgetPasswordScreen(from view: LoginViewProtocol)
    func presentSignUpScreen(from view: LoginViewProtocol)
    func presentAlertScreen(from view: LoginViewProtocol, message: String)
    func dismissLoginScreen(from view: LoginViewProtocol)
}

protocol LoginViewRemoteDataManagerInputProtocol: AnyObject{
    var remoteRequestHandler: LoginViewRemoteDataManagerOutputProtocol? { get set }
    
    // Intractor -> RemoteDataManager
    func postLoginRequest(loginModel: LoginRequestModel)
}

protocol LoginViewLocalDataManagerInputProtocol: AnyObject{
    
    static func reteriveUser() throws -> User?
    
    // INTERACTOR -> LOCALDATAMANAGER
    func saveUser(token: String, userData: UserData) throws
}

protocol LoginViewRemoteDataManagerOutputProtocol: AnyObject{
    
    //Remote Data Manager -> Intractor
    func onSucessfulLogin(token: String, user: UserData)
    func onError(message: String)
}

protocol LoginViewDelegateProtocol: AnyObject{
    func onLoginSuccess()
}

