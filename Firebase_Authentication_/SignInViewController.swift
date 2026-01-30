//
//  SignInViewController.swift
//  Firebase_Authentication_
//
//  Created by Shrikrishna Thodsare on 29/01/26.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    let emailTF = UITextField()
    let passwordTF = UITextField()
    let signInBtn = UIButton()
    let signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sign In"
        setupUI()
    }
    
    func setupUI() {
        emailTF.placeholder = "Email"
        passwordTF.placeholder = "Password"
        passwordTF.isSecureTextEntry = true
        
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.backgroundColor = .systemBlue
        signInBtn.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        signUpBtn.setTitle("Go to Sign Up", for: .normal)
        signUpBtn.setTitleColor(.systemBlue, for: .normal)
        signUpBtn.addTarget(self, action: #selector(goToSignup), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            emailTF, passwordTF, signInBtn, signUpBtn
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
    
    @objc func signInTapped() {
        
        guard let email = emailTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            
            let alert = UIAlertController(
                title: "Missing Information",
                message: "Please enter email and password.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self = self else { return }
            
            // ❌ Failed sign in
            if let error = error {
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(
                        title: "Sign In Failed",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
                return
            }
            
            // ✅ Success sign in
            DispatchQueue.main.async {
                
                let alert = UIAlertController(
                    title: "Signed In",
                    message: "You have successfully signed in.",
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
            }
            
            print("Successfully signed in")
        }
    }
    
    @objc func goToSignup() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)

    }
}
