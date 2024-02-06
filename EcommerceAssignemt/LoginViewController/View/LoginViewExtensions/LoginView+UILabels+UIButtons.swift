//
//  LoginView+UILabels+UIButtons.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

//MARK: Setting up UILabels and UIButtons Looks
extension LoginView{
    func setUpLblProperties(){
        // Setting Up Login Label
        loginLabel.lineBreakMode = .byWordWrapping
        loginLabel.numberOfLines = 0
        loginLabel.textColor = UIColor(red:251.0/255.0, green:0.0/255.0, blue:121.0/255.0, alpha:1)
        let loginTextContent = "Log In"
        let loginTextString = NSMutableAttributedString(string: loginTextContent, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 18)!
            ])
        let loginTextRange = NSRange(location: 0, length: loginTextString.length)
        let loginParagraphStyle = NSMutableParagraphStyle()
        loginParagraphStyle.lineSpacing = 1.17
        loginParagraphStyle.alignment = .center
        loginTextString.addAttribute(NSAttributedString.Key.paragraphStyle, value:loginParagraphStyle, range: loginTextRange)
        loginLabel.attributedText = loginTextString
        loginLabel.sizeToFit()
        
        // setting up ForgetPassword
        lblForgetPassword.lineBreakMode = .byWordWrapping
        lblForgetPassword.numberOfLines = 0
        lblForgetPassword.textColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1)
        let forgetPasswordTextContent = "Forget password?"
        let forgetPasswordTextString = NSMutableAttributedString(string: forgetPasswordTextContent, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 12)!
            ])
        let forgetPasswordParagraphStyle = NSMutableParagraphStyle()
        forgetPasswordParagraphStyle.alignment = .left
        let forgetPasswordtextRange = NSRange(location: 0, length: forgetPasswordTextString.length)
        forgetPasswordTextString.addAttribute(NSAttributedString.Key.paragraphStyle, value:forgetPasswordParagraphStyle, range: forgetPasswordtextRange)
        lblForgetPassword.attributedText = forgetPasswordTextString
        lblForgetPassword.sizeToFit()
        
        //setting up
        lblDontHaveAnAccount.lineBreakMode = .byWordWrapping
        lblDontHaveAnAccount.numberOfLines = 0
        let dontHaveAccountText = "Don’t have an account? Sign up"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: dontHaveAccountText)
        attributedString.setColorForText(textForAttribute: "Don’t have an account?", withColor: UIColor(red:0.38, green:0.37, blue:0.36, alpha:1))
        
        attributedString.setFontForText(textForAttribute: "Don’t have an account?", withFont: UIFont(name: "Lato-Regular", size: 15)!)
        attributedString.setColorForText(textForAttribute: "Sign up", withColor: UIColor(red:251.0/255.0, green:0.0/255.0, blue:121.0/255.0, alpha:1))
         
        attributedString.setFontForText(textForAttribute: "Sign up", withFont: UIFont(name: "Lato-Regular", size: 15)!)
        lblDontHaveAnAccount.attributedText = attributedString
        lblDontHaveAnAccount.sizeToFit()
        
        //login button
 
        btnLogin.layer.cornerRadius = 6
        btnLogin.titleLabel?.font = .latoSemiBold14
        btnLogin.tintColor = .white
        btnLogin.backgroundColor = UIColor(named: "buttonPinkColor")
        btnLogin.layer.masksToBounds = false
 
    }
}
