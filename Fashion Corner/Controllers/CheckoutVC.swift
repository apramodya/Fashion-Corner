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

        tableView.delegate = self
        tableView.dataSource = self
        
        setupPaymentInfo()
    }

    private func setupPaymentInfo() {
        subtotalLbl.text = StripeCart.subTotal.centsToFormattedCurrency()
        processingFeeLbl.text = StripeCart.processingFee.centsToFormattedCurrency()
        shippingCostLbl.text = StripeCart.shippingFee.centsToFormattedCurrency()
        totalLbl.text = StripeCart.total.centsToFormattedCurrency()
    }
    
    @IBAction func paymentMethodClicked(_ sender: Any) {
    }
    @IBAction func shippingMethodClicked(_ sender: Any) {
    }
    @IBAction func placeOrderClicked(_ sender: Any) {
    }
}

extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StripeCart.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell {
            let item = StripeCart.cartItems[indexPath.row]
            cell.configureCell(item: item)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
