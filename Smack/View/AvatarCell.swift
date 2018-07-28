//
//  AvatarCell.swift
//  Smack
//
//  Created by My Macbook Pro on 27/07/2018.
//  Copyright © 2018 My Macbook Pro. All rights reserved.
//

import UIKit


enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    func setupView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    func configureCell(index: Int, type:AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark" + String(index))
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light" + String(index))
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
}
