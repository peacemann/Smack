//
//  SocketService.swift
//  Smack
//
//  Created by My Macbook Pro on 29/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var manager : SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
    var socket : SocketIOClient!

    
    func establishConnection() {
        socket = manager.defaultSocket
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            
//Swift 4 JSON (Alternative way)
//            let newChannel = Channel(_id: "fdfdfdfkuu", name: channelName, description: channelDesc, __v: 0)
            
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
        
    }
    
    func addMessage(messaageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messaageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
}
