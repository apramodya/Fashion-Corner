//
//  ItemVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 8/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Kingfisher

class ItemVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var usualPriceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var finalPriceLbl: UILabel!
    
    var selectedItem: FashionItem!
    var usualPrice = 0.0
    var finalPrice = 0.0
    var discount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImg.layer.cornerRadius = 8
        
        discount = selectedItem.discountPercentage
        usualPrice = selectedItem.price
        finalPrice = (usualPrice * (1-discount)).rounded()
        
        if discount > 0 {
            usualPriceLbl.text = "UP Rs.\(Int(usualPrice))"
            discountLbl.text = "\(Int(discount*100))% off"
            finalPriceLbl.text = "Today Rs.\(Int(finalPrice))"
        } else {
            usualPriceLbl.text = "UP Rs.\(Int(usualPrice))"
            discountLbl.isHidden = true
            finalPriceLbl.isHidden = true
        }
        
        titleLbl.text = selectedItem.name
        descriptionLbl.text = selectedItem.description
        
        if let url = URL(string: selectedItem.imageUrl) {
            let placeholderImage = UIImage(named: "placeholder")
            itemImg.kf.indicatorType = .activity
            itemImg.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        }
    }
    
    @IBAction func addToWishlistClicked(_ sender: Any) {
        print(StripeCart.cartItems.map({$0.name}))
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        if userService.isGuest {
            self.simpleAlert(title: "Guest Account", message: "Please login to proceed!")
            return
        }
        
        StripeCart.addItemToCart(item: selectedItem)
        self.simpleAlert(title: "Item added", message: "Item added to the cart successfully!")
    }
    
}
