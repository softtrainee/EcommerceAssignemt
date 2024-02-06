//
//  LoginView+UITextFieldDelegate.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

extension LoginView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsernameValue{
            txtPasswordValue.becomeFirstResponder()
        }
        
        if textField == txtPasswordValue{
            txtPasswordValue.resignFirstResponder()
            processLogin()
        }
        return true
    }
}
