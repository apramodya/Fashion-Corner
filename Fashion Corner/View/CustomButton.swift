//
//  CustomButton.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 8/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
