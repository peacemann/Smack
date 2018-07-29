//
//  Constants.swift
//  Smack
//
//  Created by My Macbook Pro on 26/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ Succes: Bool) ->()


// URL Constans

let BASE_URL = "https://my-new-chat-chat-app.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

//Colors

let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//Notification Contstants

let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")


//Segues
let TO_LOGIN = "toLogin"
let TO_CREATEACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"


//User Deafaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers

let HEADER = [
    
    "Content-Type":"application/json; charset=utf-8"
]

let BEARER_HEADER = [
    
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type":"application/json; charset=utf-8"
]
