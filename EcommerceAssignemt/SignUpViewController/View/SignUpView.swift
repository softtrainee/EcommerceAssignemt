//
//  SignUpView.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//


import UIKit

class SignUpView: UIViewController{
    
    var presenter: SignUpViewPresenterProtocol?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var constraintContentHeight: NSLayoutConstraint!
    
    @IBOutlet var lblSignUpTitle: UILabel!
    @IBOutlet var txtFullName: UITextField! { didSet{ txtFullName.delegate = self }}
    @IBOutlet var txtEmailAddress: UITextField! { didSet{ txtEmailAddress.delegate = self }}
    @IBOutlet var txtPassword: UITextField! { didSet{ txtPassword.delegate = self }}
    @IBOutlet var txtConfirmPassword: UITextField! { didSet{ txtConfirmPassword.delegate = self }}
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var lblAlreadyHaveAccount: UILabel!
    
    var activeTextField: UITextField!
    var lastContentOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLblProperties()
        setUpTapGestures()
        addDoneButtonOnKeyboard(parentView: self.view, textField: txtFullName)
        addDoneButtonOnKeyboard(parentView: self.view, textField: txtEmailAddress)
        addDoneButtonOnKeyboard(parentView: self.view, textField: txtPassword)
        addDoneButtonOnKeyboard(parentView: self.view, textField: txtConfirmPassword)
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func signUpPressed(sender: UIButton) {
       processSignUp()
    }
    
    func processSignUp(){
        if let fullName = txtFullName.text,
            let email = txtEmailAddress.text,
            let password = txtPassword.text,
            let confirmPassword = txtConfirmPassword.text{
            presenter?.signUp(name: fullName, email: email, password: password, confirmPassword: confirmPassword)
        }else{
            showError(message: "Fields cannot be empty.")
        }
    }
}
