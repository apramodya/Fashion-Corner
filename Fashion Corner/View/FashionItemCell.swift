//
//  FashionItemCell.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 7/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Kingfisher

class FashionItemCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var usualPriceLbl: UILabel!
    @IBOutlet weak var finalPriceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    
    var usualPrice = 0.0
    var finalPrice = 0.0
    var discount = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 5
    }

    func configureCell(item: FashionItem) {
        discount = item.discountPercentage
        usualPrice = item.price
        finalPrice = (usualPrice * (1-discount)).rounded()
        
        if discount > 0 {
            usualPriceLbl.text = "Rs.\(Int(usualPrice))"
            discountLbl.text = "\(Int(discount*100))%"
            finalPriceLbl.text = "Rs.\(Int(finalPrice))"
        } else {
            discountLbl.isHidden = true
            finalPriceLbl.isHidden = true
        }
        
        displayName.text = item.name
        
        if let url = URL(string: item.imageUrl) {
            let placeholderImage = UIImage(named: "placeholder")
            displayImage.kf.indicatorType = .activity
            displayImage.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        }
    }
}
