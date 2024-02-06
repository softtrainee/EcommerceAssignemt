//
//  SignUpWireFrame.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import UIKit

class SignUpWireFrame: SignUpWireFrameProtocol{
    
    var delegate: SignUpViewDelegateProtocol?
    
    static func createSignUpViewModule(delegate: SignUpViewDelegateProtocol? = nil) -> UIViewController {
        let viewController = SignUpView(nibName: "SignUpView", bundle: nil)
        let view = viewController as SignUpViewProtocol
        let presenter: SignUpViewPresenterProtocol & SignUpViewInteratorOutputProtocol = SignUpViewPresenter()
        let interactor: SignUpViewInteractorInputProtocol & SignUpRemoteDataManagerOutputProtocol = SignUpViewInteractor()
        let remoteDataManager: SignUpRemoteDataManagerInputProtocol = SignUpViewRemoteDataManager()
        let localDataManager: SignUpLocalDataManagerInputProtocol = SignUpViewLocalDataManager()
        let wireframe: SignUpWireFrameProtocol = SignUpWireFrame()
            
        view.presenter = presenter
            
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
            
        remoteDataManager.remoteRequestHandler = interactor
        
        wireframe.delegate = delegate
        
        return viewController
    }
    
    func presentHomeScreen(from view: SignUpViewProtocol) {
        self.delegate?.onSignUpSuccess()
    }
    
    func presentLoginScreen(from view: SignUpViewProtocol) {
        if let view = view as? UIViewController{
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    func alertScreen(from view: SignUpViewProtocol, message: String) {
        if let view = view as? UIViewController{
            showAlertWithMessage(view: view, message: message)
        }
    }
}
