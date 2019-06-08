//
//  HomeCollectionViewCell.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 8/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(homeItem: HomeItem) {
        if let url = URL(string: homeItem.imageUrl) {
            let placeholderImage = UIImage(named: "placeholder")
            viewImg.kf.indicatorType = .activity
            viewImg.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        }
    }
}
