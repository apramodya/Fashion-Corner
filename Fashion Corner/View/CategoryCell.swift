//
//  CategoryCell.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 2/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryImage.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(category: Category) {
        categoryTitle.text = category.name
        if let url = URL(string: category.imageUrl) {
            let placeholderImage = UIImage(named: "placeholder")
            categoryImage.kf.indicatorType = .activity
            categoryImage.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        }
    }

}
