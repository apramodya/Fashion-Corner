//
//  CartItemCell.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Kingfisher

class CartItemCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemLbl: UILabel!
    
    private var item: FashionItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 5
    }

    func configureCell(item: FashionItem) {
        itemLbl.text = item.name
        
        if let url = URL(string: item.imageUrl) {
            itemImg.kf.setImage(with: url)
        }
    }
    
    @IBAction func removeItemClicked(_ sender: Any) {
    }
}
