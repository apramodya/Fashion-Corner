//
//  HomeVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 2/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var homeItems = [HomeItem]()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        
        getItems()
    }
    
    func getItems() {
        spinner.startAnimating()
        db.collection("homeItems").order(by: "order").getDocuments { (snap, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            for document in snap!.documents {
                let data = document.data()
                let newItem = HomeItem(data: data)
                self.homeItems.append(newItem)
            }
            
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
        
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            cell.configCell(homeItem: homeItems[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 30 )
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
