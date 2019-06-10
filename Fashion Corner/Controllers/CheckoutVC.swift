//
//  CheckoutVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 10/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var paymentMethodBtn: UIButton!
    @IBOutlet weak var shippingMethodBtn: UIButton!
    @IBOutlet weak var subtotalLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var shippingCostLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func paymentMethodClicked(_ sender: Any) {
    }
    @IBAction func shippingMethodClicked(_ sender: Any) {
    }
    @IBAction func placeOrderClicked(_ sender: Any) {
    }
    
}
