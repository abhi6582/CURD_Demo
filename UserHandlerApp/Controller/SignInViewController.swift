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

    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Give curve to button
        self.btnSignIn.layer.cornerRadius = 12.0
        self.btnSignIn.clipsToBounds = true
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
        // email sign in using Firebase.
        Auth.auth().signIn(withEmail: LoginUser.userEmail, password: LoginUser.userPassword) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                // On success navigate to profile view.
                self.performSegue(withIdentifier: K.profileListSegue, sender: self)
            }
        }
    }
    
}
