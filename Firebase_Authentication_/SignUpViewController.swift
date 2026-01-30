//
//  SignUpViewController.swift
//  Firebase_Authentication_
//
//  Created by Shrikrishna Thodsare on 29/01/26.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let emailTF = UITextField()
    let passwordTF = UITextField()
    let signupBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sign Up"
        setupUI()
    }
    
    func setupUI() {
        emailTF.placeholder = "Email"
        passwordTF.placeholder = "Password"
        passwordTF.isSecureTextEntry = true
        
        signupBtn.setTitle("Create Account", for: .normal)
        signupBtn.backgroundColor = .systemGreen
        signupBtn.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            emailTF, passwordTF, signupBtn
        ])
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    @objc func signUpTapped() {
        
        guard let email = emailTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Missing Information",
                    message: "Please enter both email and password.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self = self else { return }
            
            // ❌ Failed Alert
            if let error = error {
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(
                        title: "Registration Failed",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alert, animated: true)
                }
                
                return
            }
            
            // ✅ Success Alert
            DispatchQueue.main.async {
                
                let alert = UIAlertController(
                    title: "Registration Successful",
                    message: "Your account has been created successfully.\nYou may now sign in to continue.",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // later you can navigate to login screen here
                }
                
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
            }
        }
    }
}
