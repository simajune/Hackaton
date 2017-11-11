//
//  CustomButton.swift
//  Hackaton
//
//  Created by SIMA on 2017. 11. 10..
//  Copyright © 2017년 FC. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 17.5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }

}
