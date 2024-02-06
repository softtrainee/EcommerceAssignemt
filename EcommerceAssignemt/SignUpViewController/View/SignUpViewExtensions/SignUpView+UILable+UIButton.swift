//
//  SignUpView+UILable+UIButton.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//
import UIKit

extension SignUpView{
    
    func setUpLblProperties(){
        // Setting Up Login Label
        lblSignUpTitle.lineBreakMode = .byWordWrapping
        lblSignUpTitle.numberOfLines = 0
        lblSignUpTitle.textColor = UIColor(red:251.0/255.0, green:0.0/255.0, blue:121.0/255.0, alpha:1)
        let signUpTextContent = "Sign Up"
        let signUpTextString = NSMutableAttributedString(string: signUpTextContent, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 18)!
            ])
        let loginTextRange = NSRange(location: 0, length: signUpTextString.length)
        let loginParagraphStyle = NSMutableParagraphStyle()
        loginParagraphStyle.lineSpacing = 1.17
        loginParagraphStyle.alignment = .center
        signUpTextString.addAttribute(NSAttributedString.Key.paragraphStyle, value:loginParagraphStyle, range: loginTextRange)
        lblSignUpTitle.attributedText = signUpTextString
        lblSignUpTitle.sizeToFit()
        
        //setting up
        lblAlreadyHaveAccount.lineBreakMode = .byWordWrapping
        lblAlreadyHaveAccount.numberOfLines = 0
        let dontHaveAccountText = "Aleady have an account? Login"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: dontHaveAccountText)
        attributedString.setColorForText(textForAttribute: "Aleady have an account?", withColor: UIColor(red:0.38, green:0.37, blue:0.36, alpha:1))
       
        attributedString.setFontForText(textForAttribute: "Aleady have an account?", withFont: UIFont(name: "Lato-Regular", size: 15)!)
        attributedString.setColorForText(textForAttribute: "Login", withColor: UIColor(red:251.0/255.0, green:0.0/255.0, blue:121.0/255.0, alpha:1))
     
        attributedString.setFontForText(textForAttribute: "Login", withFont: UIFont(name: "Lato-Regular", size: 15)!)
        lblAlreadyHaveAccount.attributedText = attributedString
        lblAlreadyHaveAccount.sizeToFit()
        
        //login button
 
        btnSignUp.layer.cornerRadius = 6
        btnSignUp.titleLabel?.font = .latoSemiBold14
        btnSignUp.tintColor = .white
        btnSignUp.backgroundColor = UIColor(named: "buttonPinkColor")
        btnSignUp.layer.masksToBounds = false
 
    }
}
