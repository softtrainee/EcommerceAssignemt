//
//  SignUpViewProtocols.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import UIKit

protocol SignUpViewProtocol: AnyObject{
    var presenter: SignUpViewPresenterProtocol? { get set }
    
    // Presenter -> View
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol SignUpViewPresenterProtocol: AnyObject{
    var view: SignUpViewProtocol? { get set }
    var interactor: SignUpViewInteractorInputProtocol? { get set }
    var wireframe: SignUpWireFrameProtocol? { get set }
    
    //View -> Presenter
    func viewDidLoad()
    func signUp(name: String, email: String, password: String, confirmPassword: String)
    func signIn()
    func routeToHomeScreen()
    func showAlert(message: String)
}

protocol SignUpViewInteractorInputProtocol: AnyObject{
    var presenter: SignUpViewInteratorOutputProtocol? { get set }
    var remoteDataManager: SignUpRemoteDataManagerInputProtocol? { get set }
    var localDataManager: SignUpLocalDataManagerInputProtocol? { get set }
    
    //Presenter -> Intractor
    func postSignUpRequest(name: String, email: String, password: String)
}

protocol SignUpViewInteratorOutputProtocol: AnyObject{
    
    // Intractor -> Presenter
    func didSignUpCompleted()
    func onError(message: String)
}

protocol SignUpWireFrameProtocol: AnyObject{
    
    var delegate: SignUpViewDelegateProtocol? { get set }
    
    static func createSignUpViewModule(delegate: SignUpViewDelegateProtocol?) -> UIViewController
    
    //Presenter -> WireFrame
    func presentHomeScreen(from view: SignUpViewProtocol)
    func presentLoginScreen(from view: SignUpViewProtocol)
    func alertScreen(from view: SignUpViewProtocol, message: String)
}

protocol SignUpRemoteDataManagerInputProtocol: AnyObject{
    var remoteRequestHandler: SignUpRemoteDataManagerOutputProtocol? { get set }
    
    // Intractor -> RemoteDataManager
    func postSignUpRequest(signupModel: SignUpRequestModel)
}

protocol SignUpLocalDataManagerInputProtocol: AnyObject{
    func saveUser(token: String, userData: UserData) throws
}

protocol SignUpRemoteDataManagerOutputProtocol: AnyObject{
    
    //RemoteDataManager -> Intractor
    func onSucessfulSignUp(token: String, user: UserData)
    func onError(message: String)
}

protocol SignUpViewDelegateProtocol: AnyObject{
    func onSignUpSuccess()
}

