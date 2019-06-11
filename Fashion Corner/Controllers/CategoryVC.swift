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
    @IBOutlet weak var loginLogoutBtn: UIBarButtonItem!
    
    var categories = [Category]()
    var db: Firestore!
    var selectedGender: String = "ladies"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        setupInitialAnonymousUser()
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        categories.removeAll()
        getCategories()
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginLogoutBtn.title = "Logout"
            if userService.userListner == nil {
                userService.getCurrentUser()
            }
        } else {
            loginLogoutBtn.title = "Login"
        }
    }

    func getCategories() {
        spinner.startAnimating()
        db.collection("categories").whereField("gender", isEqualTo: selectedGender).order(by: "order").getDocuments { (snap, error) in
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
    
    func setupInitialAnonymousUser() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                }
            }
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
    
    fileprivate func presentLoginController() {
        let stroyboard = UIStoryboard(name: "LoginSB", bundle: nil)
        let controller = stroyboard.instantiateViewController(withIdentifier: "LoginSB")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginLogoutClicked(_ sender: Any) {
        guard let user = Auth.auth().currentUser else { return}
        
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                userService.logoutUser()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint(error)
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItemsCollection", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemsCollection" {
            let destinationVC = segue.destination as! ItemsCollectionVC

            if let indexPath = self.tableView.indexPathForSelectedRow {
                let category = self.categories[indexPath.row]
                destinationVC.selectedCategory = category
            }
        }
    }
}
