//
//  CategoryVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 2/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Firebase

class CategoryVC: UIViewController {

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var categories = [Category]()
    var db: Firestore!
    var listner: ListenerRegistration!
    var selectedGender: String = "ladies"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        getCategories()
    }

    func getCategories() {
        spinner.startAnimating()
        db.collection("categories").whereField("gender", isEqualTo: selectedGender).getDocuments { (snap, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            
            for document in snap!.documents {
                let data = document.data()
                let newCategory = Category(data: data)
                self.categories.append(newCategory)
            }
            
            self.spinner.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }

    }
    @IBAction func segmentTapped(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            selectedGender = "ladies"
            categories.removeAll()
            getCategories()
        case 1:
            selectedGender = "mens"
            categories.removeAll()
            getCategories()
        default:
            print("Error")
        }
    }
    
}
extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
