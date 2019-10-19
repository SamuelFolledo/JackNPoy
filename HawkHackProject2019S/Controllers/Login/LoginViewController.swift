//
//  LoginViewController.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 3/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
//MARK: IBOutlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	@IBOutlet weak var emailView: MyView!
	@IBOutlet weak var passwordView: MyView!
	
// MARK: - Properties
//	private var client: LoginClient?
	
// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if isUserLoggedIn() {
			let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
				User.logOutCurrentUser(withBlock: { (success) in
					if !success {
						Service.presentAlert(on: self, title: "Logout Error", message: "Unknown Error logging out. Please try again."); return
					}
				})
			}
			let noAction = UIAlertAction(title: "No", style: .default) { (action) in
				self.dismiss(animated: true, completion: nil)
			}
			Service.alertWithActions(on: self, actions: [logoutAction, noAction], title: "Hello \(User.currentUser()!.name)", message: "In order to log in, you need to log out first. Would you like to log out?")
		}
	}
	
	
	
	//MARK: Private Methods
	private func setupViews() {
		title = "Login"
		
		emailView.layer.borderWidth = 2
		emailView.layer.borderColor = kCLEARCGCOLOR
		passwordView.layer.borderWidth = 1
		passwordView.layer.borderColor = kCLEARCGCOLOR
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		passwordTextField.returnKeyType = .go
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
		self.view.addGestureRecognizer(tap)
	}
	
	//login
	private func login() {
		var errorCounter = 0
		let methodStart = Date()
		
		guard let email = emailTextField.text?.trimmedString() else {
			emailView.layer.borderColor = kREDCGCOLOR; return
		}
		guard let password = passwordTextField.text?.trimmedString() else {
			passwordView.layer.borderColor = kREDCGCOLOR; return
		}
		
		if !(email.isValidEmail) { //if email is not valid
			errorCounter += 1
			emailView.layer.borderColor = kREDCGCOLOR
			Service.presentAlert(on: self, title: "Invalid Email", message: "Email format is not valid. Please try again with another email")
		} else {
			emailView.layer.borderColor = kCLEARCGCOLOR
		}
		if password.count < 6 {
			errorCounter += 1
			self.passwordView.layer.borderColor = kREDCGCOLOR
			Service.presentAlert(on: self, title: "Password Count Error", message: "Password must be at least 6 characters")
			return
		} else {
			passwordView.layer.borderColor = kCLEARCGCOLOR
		}
		
		switch errorCounter {
		case 0:
			
			User.loginUserWith(email: email, password: password) { (error) in
				if let error = error {
					Service.presentAlert(on: self, title: "Login Error", message: error.localizedDescription)
					return
				} else {
					
					//finished logging in
					DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
						let methodFinish = Date()
						let executionTime = methodFinish.timeIntervalSince(methodStart) //to get the executionTime
						
						let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
							self.navigationController?.popToRootViewController(animated: true)
						}
						Service.alertWithActions(on: self, actions: [okAction], title: "Success!", message: "Successfully logged in \(executionTime) milliseconds")
					})
				}
			}
			
		default:
			Service.presentAlert(on: self, title: "Error", message: "There are errors on the field. Please try again.")
			return
		}
	}
	
//MARK: Helpers
	@objc func handleDismissTap(_ gesture: UITapGestureRecognizer) { //dismiss fields
		self.view.endEditing(false)
	}
	
// MARK: - Actions
	@IBAction func loginButtonTapped(_ sender: Any) {
		login()
	}
	
}

//MARK: Extensions
extension LoginViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case emailTextField:
			passwordTextField.becomeFirstResponder()
		case passwordTextField:
			login() //loging on return click
		default:
			textField.resignFirstResponder()
		}
		return true
	}
}
