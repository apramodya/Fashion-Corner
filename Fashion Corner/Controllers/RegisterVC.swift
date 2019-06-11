//
//  RegisterVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Some fields are missing.")
                return
        }
        
        guard let confirmPassword = confirmPasswordTxt.text, confirmPassword == password else {
            simpleAlert(title: "Error", message: "Passwords do not match.")
            return
        }
        
        spinner.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint(error)
                self.spinner.stopAnimating()
                return
            }
            
            guard let firUser = result?.user else { return}
            let customer = User(id: firUser.uid, email: email, stripeId: "")
            
            self.createFireUser(user: customer)
        }
    }
    
    func createFireUser(user: User) {
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        let data = User.modelToData(user: user)
        newUserRef.setData(data) { (error) in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint(error)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            self.spinner.stopAnimating()
            return
        }
    }
}
