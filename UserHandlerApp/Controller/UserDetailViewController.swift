//
//  UserDetailViewController.swift
//  UserHandlerApp
//
//  Created by Abhishek Dudhrejia on 11/07/20.
//  Copyright © 2020 Abhishek Dudhrejia. All rights reserved.
//

import UIKit
import Firebase


class UserDetailViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var btnBlue: UIButton!
    @IBOutlet weak var btnPurple: UIButton!
    @IBOutlet weak var btnGreen: UIButton!
    @IBOutlet weak var btnRed: UIButton!
    @IBOutlet weak var btnYellow: UIButton!
    
    
    @IBOutlet weak var btnSaveOrUpdate: CurvyButton!
    
    var profileColor = "blue"
    
    var userForModification: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if userForModification == nil {
            self.title = "Create Profile"
            self.btnSaveOrUpdate.setTitle("Save", for: .normal)
        } else {
            self.title = "Edit Profile"
            self.btnSaveOrUpdate.setTitle("Update", for: .normal)
            loadUser()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        userForModification = nil
    }
    
    func loadUser() {
        firstNameText.text = userForModification?.firstName
        lastNameText.text = userForModification?.lastName
        emailText.text = userForModification?.email
        descriptionText.text = userForModification?.description
        
        if userForModification?.profileColor == "blue" {
            btnBlue.setTitle("√", for: .normal)
        } else if userForModification?.profileColor == "purple" {
            btnPurple.setTitle("√", for: .normal)
        } else if userForModification?.profileColor == "green" {
            btnGreen.setTitle("√", for: .normal)
        } else if userForModification?.profileColor == "red" {
            btnRed.setTitle("√", for: .normal)
        } else if userForModification?.profileColor == "yellow" {
            btnYellow.setTitle("√", for: .normal)
        }
         
    }
    
    
    
    @IBAction func selectProfileColor(_ sender: UIButton) {
        btnBlue.setTitle("", for: .normal)
        btnPurple.setTitle("", for: .normal)
        btnGreen.setTitle("", for: .normal)
        btnRed.setTitle("", for: .normal)
        btnYellow.setTitle("", for: .normal)
        switch sender.tag {
        case 1:
            print(ProfileColor.blue)
            profileColor = "blue"
            sender.setTitle("√", for: .normal)
        case 2:
            print(ProfileColor.purple)
            profileColor = "purple"
            sender.setTitle("√", for: .normal)
        case 3:
            print(ProfileColor.green)
            profileColor = "green"
            sender.setTitle("√", for: .normal)
        case 4:
            print(ProfileColor.red)
            profileColor = "red"
            sender.setTitle("√", for: .normal)
        case 5:
            print(ProfileColor.yellow)
            profileColor = "yellow"
            sender.setTitle("√", for: .normal)
        default:
            print("please select profile color")
        }
        
    }
    
    @IBAction func saveUser(_ sender: UIButton) {
        // Create new profile
        if userForModification == nil {
            if let firstName = self.firstNameText.text, let lastName = self.lastNameText.text, let email = emailText.text, let desc = descriptionText.text {
                if Auth.auth().currentUser != nil {
                    db.collection(K.FStore.collectionName).addDocument(data: [
                        K.FStore.firstName: firstName,
                        K.FStore.lastName: lastName,
                        K.FStore.email: email,
                        K.FStore.description: desc,
                        K.FStore.profileColor: profileColor,
                        K.FStore.date: Date().timeIntervalSince1970
                    ]) { (error) in
                        if let e = error {
                            print("There was an issue saving data to firestore: \(e.localizedDescription)")
                        } else {
                            print("Successfuly saved data")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } else {
                    print("No signed in user found...")
                }
            } else {
                print("Please enter value in field")
            }
        } else {
            // Modify existing profile
            if let user = userForModification {
                let washingtonRef = db.collection(K.FStore.collectionName).document(user.firbaseDocument)
                if let firstName = self.firstNameText.text, let lastName = self.lastNameText.text, let email = emailText.text, let desc = descriptionText.text {
                    washingtonRef.updateData([
                        K.FStore.firstName: firstName,
                        K.FStore.lastName: lastName,
                        K.FStore.email: email,
                        K.FStore.description: desc,
                        K.FStore.profileColor: profileColor,
                        K.FStore.date: Date().timeIntervalSince1970
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } else {
                    print("Please enter value in field")
                }
            }
        }
        
    }
    
    
}
