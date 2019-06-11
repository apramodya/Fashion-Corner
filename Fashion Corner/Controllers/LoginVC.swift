//
//  LoginVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
    }
    
    @IBAction func registerClicked(_ sender: Any) {
    }
    
    @IBAction func guestClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    }
}
