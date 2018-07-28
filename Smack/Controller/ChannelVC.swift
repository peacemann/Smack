//
//  ChannelVC.swift
//  Smack
//
//  Created by My Macbook Pro on 26/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareforUnwind (segue: UIStoryboardSegue){}
    
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.85
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            
            //My method (Alternative) to convert String to CGFloat Color
            
//            var bgColor = UserDataService.instance.avatarColor
//            bgColor = String(bgColor.dropFirst())
//            bgColor = String(bgColor.dropLast())
//
//            let colorArray = bgColor.split(separator: ",")
//            var newColorArray: [CGFloat] = []
//
//            for item in colorArray {
//                newColorArray.append( CGFloat((item as NSString).floatValue) )
//            }
//
//            userImg.backgroundColor = UIColor(red: newColorArray[0], green: newColorArray[1], blue: newColorArray[2], alpha: newColorArray[3])
            
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
//
            
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    

}
