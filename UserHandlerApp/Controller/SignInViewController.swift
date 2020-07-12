//
//  SignInViewController.swift
//  UserHandlerApp
//
//  Created by Abhishek Dudhrejia on 11/07/20.
//  Copyright © 2020 Abhishek Dudhrejia. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func signInUsingFirebase(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: LoginUser.userEmail, password: LoginUser.userPassword) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: K.profileListSegue, sender: self)
            }
        }
    }
    
}
