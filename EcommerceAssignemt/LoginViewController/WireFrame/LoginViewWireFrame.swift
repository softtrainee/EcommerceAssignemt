//
//  LoginViewWireFrame.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import UIKit

class LoginViewWireFrame: LoginViewWireFrameProtocol{
    
    var delegate: LoginViewDelegateProtocol?
    
    static func createLoginViewModule(delegate: LoginViewDelegateProtocol? = nil) -> UIViewController {
        let viewController = LoginView(nibName: "LoginView", bundle: nil)
        let view = viewController as LoginViewProtocol
        let presenter: LoginViewPresenterProtocol & LoginViewInteractorOutputProtocol = LoginViewPresenter()
        let interactor: LoginViewInteractorInputProtocol & LoginViewRemoteDataManagerOutputProtocol = LoginViewInteractor()
        let remoterDataManager: LoginViewRemoteDataManagerInputProtocol = LoginViewRemoteDataManager()
        let localDataManager: LoginViewLocalDataManagerInputProtocol = LoginViewLocalDataManager()
        let wireFrame: LoginViewWireFrameProtocol = LoginViewWireFrame()
            
        view.presenter = presenter
            
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoterDataManager
        interactor.localDataManager = localDataManager
        
        remoterDataManager.remoteRequestHandler = interactor
        
        wireFrame.delegate = delegate
        
        return viewController
    }
    
    func presentHomeScreen(from view: LoginViewProtocol) {
        if let view = view as? UIViewController{
            delegate?.onLoginSuccess()
            view.navigationController?.popViewController(animated: true)
        }
    }
    
    func presentForgetPasswordScreen(from view: LoginViewProtocol) {
        
    }
    
    func presentSignUpScreen(from view: LoginViewProtocol) {
        let signUpScreen = SignUpWireFrame.createSignUpViewModule()

        if let view = view as? UIViewController{
            view.present(signUpScreen, animated: true, completion: nil)
        }
    }
    
    func presentAlertScreen(from view: LoginViewProtocol, message: String) {
        if let view = view as? UIViewController{
            showAlertWithMessage(view: view, message: message)
        }
    }
    
    func dismissLoginScreen(from view: LoginViewProtocol) {
        if let view = view as? UIViewController{
            view.navigationController?.popViewController(animated: true)
        }
    }
}
