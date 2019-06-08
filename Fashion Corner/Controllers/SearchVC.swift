//
//  SearchVC.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 2/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var db: Firestore!
    var filteredItems = [FashionItem]()
    var finishedEnteringSearchString = false
    var searchedString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FashionItemCell", bundle: nil), forCellWithReuseIdentifier: "FashionItemCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func searchForItems(searchText: String) {

        db.collection("items").whereField("tags", arrayContains: searchText.lowercased()).getDocuments { (snap, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            
            for document in snap!.documents {
                let data = document.data()
                let newItem = FashionItem(data: data)
                self.filteredItems.append(newItem)
            }
            
            self.collectionView.reloadData()
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedString = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        finishedEnteringSearchString = true
        searchBar.resignFirstResponder()
        
        filteredItems.removeAll()
        searchForItems(searchText: searchedString)
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FashionItemCell", for: indexPath) as? FashionItemCell {
            cell.configureCell(item: filteredItems[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 50 ) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
