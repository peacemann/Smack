//
//  ChannelVC.swift
//  Smack
//
//  Created by My Macbook Pro on 26/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareforUnwind (segue: UIStoryboardSegue){}
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.85
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setupUserInfo()
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
        

    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            
            //Show profile page
            
            let profie = ProfileVC()
            profie.modalPresentationStyle = .custom
            present(profie, animated: true, completion: nil)
            
        } else {
            
           performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }

    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        
        setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notif: Notification) {
        
        tableView.reloadData()
    }
    
    func setupUserInfo() {
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
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
            
        }
        
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)

        
        self.revealViewController().revealToggle(animated: true)
    }
    
    

}
