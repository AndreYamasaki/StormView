//
//  DetailViewController.swift
//  Project1
//
//  Created by user on 06/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Attributes
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var pictureTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pictureTitle
        
        navigationItem.largeTitleDisplayMode = .never
        //Challenge 2 Day 23
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    //MARK: - TablewView DataSource
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    //MARK: - Methods
    
    //Challenge 2 Day 23
    @objc func sharedTapped() {
        let challengeItem = ["Day 23 challenge 2"]
        
        let vc = UIActivityViewController(activityItems: challengeItem, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
