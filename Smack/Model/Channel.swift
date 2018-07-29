//
//  Channel.swift
//  Smack
//
//  Created by My Macbook Pro on 29/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    
//    //Swift 4 : Alternative way for json
//    public private(set) var _id: String!
//    public private(set) var name: String!
//    public private(set) var description: String!
//    public private(set) var __v: Int!

    
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
