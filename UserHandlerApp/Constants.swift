//
//  Constants.swift
//  UserHandlerApp
//
//  Created by Abhishek Dudhrejia on 11/07/20.
//  Copyright © 2020 Abhishek Dudhrejia. All rights reserved.
//

import UIKit

enum ProfileColor {
    case blue
    case purple
    case green
    case red
    case yellow
}

struct K {
    static let userCellIdentifier = "userCell"
    static let profileListSegue = "goToProfileList"
    static let userDetailSegue = "goToUserDetail"
    
    struct ProfileColor {
        static let blue: UIColor = #colorLiteral(red: 0, green: 0.76063627, blue: 0.9319168329, alpha: 1)
        static let purple: UIColor = #colorLiteral(red: 0.7883672118, green: 0.4210912585, blue: 0.8412459493, alpha: 1)
        static let green: UIColor = #colorLiteral(red: 0.5591930747, green: 0.8527057767, blue: 0, alpha: 1)
        static let red: UIColor = #colorLiteral(red: 0.9122664332, green: 0.1302212179, blue: 0, alpha: 1)
        static let yellow: UIColor = #colorLiteral(red: 1, green: 0.777936697, blue: 0, alpha: 1)
    }
    
    struct FStore {
        static let collectionName = "user"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let description = "description"
        static let profileColor = "profileColor"
        static let date = "date"
    }
    
}
class LoginUser {
    static let userEmail:String = "abhishek.adorebits@gmail.com"
    static let userPassword:String = "Abhi@1234"
}


 
