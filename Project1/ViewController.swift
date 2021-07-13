//
//  ViewController.swift
//  Project1
//
//  Created by user on 05/07/21.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Attributes
    
    var pictures = [String]()
    var picturesSorted = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Challenge 2 Day 23
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        picturesSorted = pictures.sorted()  //Challenge 2: Show the list of images sorted by alphabetical order
        
    }
    
    //MARK: - TablewView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        picturesSorted.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
        cell.textLabel?.text = picturesSorted[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picturesSorted[indexPath.row]
            vc.pictureTitle = "Picture \(indexPath.row + 1) of \(picturesSorted.count)" // Challenge 3: Add "Picture (position in the list) of (number of pictures)" as the title of every picture
            navigationController?.pushViewController(vc, animated: true)
        }
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

