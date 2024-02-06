//
//  LoginViewPresenter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//
import Foundation

class LoginViewPresenter: LoginViewPresenterProtocol{
    
    var view: LoginViewProtocol?
    var interactor: LoginViewInteractorInputProtocol?
    var wireFrame: LoginViewWireFrameProtocol?
    
    func viewDidLoad() {
        // check if user is already login, then redirect to back screen, donot show login screen
        if let view = view{
            if LoginViewInteractor.isUserAlreadyLoggedIn(){
                wireFrame?.dismissLoginScreen(from: view)
            }
        }
    }
    
    func forgetPassword() {
        if let view = view{
            wireFrame?.presentForgetPasswordScreen(from: view)
        }
    }
    
    func signup() {
        if let view = view{
            wireFrame?.presentSignUpScreen(from: view)
        }
    }
    
    func signIn(username: String, password: String) {
        view?.showLoading()
        interactor?.postLoginRequest(username: username, password: password)
    }
    
    func routeToHomeScreen() {
        if let view = view{
            wireFrame?.presentHomeScreen(from: view)
        }
    }
    
    func showAlert(message: String) {
        if let view = view{
            wireFrame?.presentAlertScreen(from: view, message: message)
        }
    }
}

extension LoginViewPresenter: LoginViewInteractorOutputProtocol{
    func didLoginCompleted() {
        view?.hideLoading()
        routeToHomeScreen()
    }
    
    func onError(message: String) {
        view?.hideLoading()
        showAlert(message: message)
    }
}
