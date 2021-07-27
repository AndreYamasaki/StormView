//
//  CollectionViewController.swift
//  Project1
//
//  Created by user on 23/07/21.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    
    //MARK: - Attributes

    var pictures = [String]()
    var picturesSorted = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        picturesSorted = pictures.sorted()

    }
    
    //MARK: - Methods
    
    @objc func sharedTapped() {
        let challengeItem = ["Day 44 challenge 3"]
        
        let vc = UIActivityViewController(activityItems: challengeItem, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesSorted.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        
        vc.selectedImage = picturesSorted[indexPath.row]
        vc.totalImage = picturesSorted.count
        vc.selectedImageIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue PictureCell.")
        }
        cell.nameLabel.text = picturesSorted[indexPath.row]
        cell.imageView.image = UIImage(named: picturesSorted[indexPath.row])
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
}
