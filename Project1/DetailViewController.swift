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
    
    var selectedImageIndex: Int?
    var totalImage: Int?
    
    var selectedImage: String?
    var pictureTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pictureTitle
        
        navigationItem.largeTitleDisplayMode = .never
        
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
    


}
