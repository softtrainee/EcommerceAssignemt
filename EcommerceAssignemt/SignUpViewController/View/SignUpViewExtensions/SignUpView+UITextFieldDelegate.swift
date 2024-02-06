//
//  SignUpView+UITextFieldDelegate.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

extension SignUpView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeTextField?.resignFirstResponder()
        activeTextField = nil
        
        if textField == txtFullName{
            txtEmailAddress.becomeFirstResponder()
        }
        
        if textField == txtEmailAddress{
            txtPassword.becomeFirstResponder()
        }
        
        if textField == txtPassword{
            txtConfirmPassword.becomeFirstResponder()
        }
        
        if textField == txtConfirmPassword{
            txtConfirmPassword.resignFirstResponder()
            processSignUp()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        lastContentOffset = self.scrollView.contentOffset
        return true
    }
}
