//
//  UserListViewController.swift
//  UserHandlerApp
//
//  Created by Abhishek Dudhrejia on 11/07/20.
//  Copyright © 2020 Abhishek Dudhrejia. All rights reserved.
//

import UIKit
import Firebase

class UserListViewController: UIViewController {

    private var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var userTableView: UITableView!
    var users:[User] = []
    
    var selectedUser: User?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Created Profiles"
        
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        
        checkUserSignin()
        
        if #available(iOS 10.0, *) {
            self.userTableView.refreshControl = refreshControl
        } else {
            self.userTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshUserData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching User's Profile ...", attributes: nil)
    }
    
    @objc
    func refreshUserData(_ refresh: UIRefreshControl)  {
        loadUser()
    }
    
    func loadUser() {
        
        db.collection(K.FStore.collectionName)
            .addSnapshotListener { (QuerySnapshot, error) in
                
                if let e = error {
                    print("error in fetching data \(e.localizedDescription)")
                } else {
                    guard let documents = QuerySnapshot?.documents else {
                       print("Error fetching documents: \(error!)")
                       return
                    }
                    self.users.removeAll()
                    for i in 0 ..< documents.count {
                        let data = documents[i].data()
                        print(data)
                        let documentID = documents[i].documentID
                        print("Document ID \(documentID)")
                        
                        if let firstName = data[K.FStore.firstName] as? String, let lastName = data[K.FStore.lastName] as? String, let email = data[K.FStore.email]  as? String, let desc = data[K.FStore.description]  as? String, let profileColor = data[K.FStore.profileColor]  as? String, let timeResult = data["date"] as? Double {
                            
                            let date = Date(timeIntervalSince1970: timeResult)
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                            dateFormatter.timeZone = .current
                            let localDate = dateFormatter.string(from: date)
                            
                            let newUser = User(firbaseDocument: documentID, firstName: firstName, lastName: lastName, email: email ,description: desc, profileColor: profileColor, date: localDate)
                            
                            self.users.append(newUser)
                            
                            if self.users != nil && self.users.count > 0 {
                                DispatchQueue.main.async {
                                    self.userTableView.reloadData()
                                    self.refreshControl.endRefreshing()
                                }
                            } else {
                                print("Sorry, there is no user")
                            }
                        } else {
                            print("Error in parsing data")
                        }
                        
                    }
                    
                    if let querySnapshotDocuments = QuerySnapshot?.documents {
                        
                        for docs in querySnapshotDocuments {
                            let data = docs.data()
                            
                            
                        }
                    }
                }
        }
        
    }
    
    func checkUserSignin() {
        if Auth.auth().currentUser != nil {
           print("User is signed in.")
          loadUser()
        } else {
           print("No user is signed in.")
          // ...
        }
    }
    
    @IBAction func addUser(_ sender: UIButton) {
        performSegue(withIdentifier: K.userDetailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.userDetailSegue {
            let destination = segue.destination as! UserDetailViewController
            destination.userForModification = selectedUser
        }
        selectedUser = nil
    }
    
}
//MARK: - UITableView Delegate & Data Source
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userCellIdentifier, for: indexPath) as! UserTableViewCell
        cell.lblProfileColor?.layer.cornerRadius = 12.0
        cell.lblProfileColor?.clipsToBounds = true
        
        let user = users[indexPath.row]
        cell.lblName?.text = String("\(user.firstName) \(user.lastName)")
        cell.lblEmail?.text = user.email
        
        cell.lblDate?.text = user.date
        
        cell.lblDescription?.text = user.description
        
        if user.profileColor == "blue" {
            cell.lblProfileColor?.backgroundColor = K.ProfileColor.blue
        } else if user.profileColor == "purple" {
            cell.lblProfileColor?.backgroundColor = K.ProfileColor.purple
        } else if user.profileColor == "green" {
            cell.lblProfileColor?.backgroundColor = K.ProfileColor.green
        } else if user.profileColor == "red" {
            cell.lblProfileColor?.backgroundColor = K.ProfileColor.red
        } else if user.profileColor == "yellow" {
            cell.lblProfileColor?.backgroundColor = K.ProfileColor.yellow
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        selectedUser = user
        performSegue(withIdentifier: K.userDetailSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if editingStyle == .delete {
            self.users.remove(at: indexPath.row)
            db.collection(K.FStore.collectionName).document(user.firbaseDocument).updateData([
                K.FStore.firstName: FieldValue.delete(),
                K.FStore.lastName: FieldValue.delete(),
                K.FStore.email: FieldValue.delete(),
                K.FStore.description: FieldValue.delete(),
                K.FStore.profileColor: FieldValue.delete(),
                K.FStore.date: FieldValue.delete()
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    
                    DispatchQueue.main.async {
                        self.userTableView.reloadData()
                    }
                }
            }
        }
    }
}
