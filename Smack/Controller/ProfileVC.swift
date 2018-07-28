//
//  ProfileVC.swift
//  Smack
//
//  Created by My Macbook Pro on 28/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(_ sender: Any) {
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        if true { //UserDataService.instance.name != ""
            
            self.profileImg.image = UIImage(named: UserDataService.instance.avatarName)
            self.userName.text = UserDataService.instance.name
            self.userEmail.text = UserDataService.instance.email
            self.profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
            let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
            bgView.addGestureRecognizer(closeTouch)
        }

    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
