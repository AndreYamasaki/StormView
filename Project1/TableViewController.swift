//
//  ViewController.swift
//  Project1
//
//  Created by user on 05/07/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    //MARK: - Attributes
    
    var pictures = [String]()
    var picturesSorted = [String]()
    var picViews = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Challenge 2 Day 22: Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                picViews[item] = 0
            }
        }
//Challenge 2: Show the list of images sorted by alphabetical order
        picturesSorted = pictures.sorted()
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "picViews") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                picViews = try jsonDecoder.decode([String: Int].self, from: savedData)
            } catch {
                print("could not load data")
            }
        }
        
    }
    
    //MARK: - TablewView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        picturesSorted.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
        let views = picturesSorted[indexPath.row]
        cell.textLabel?.text = picturesSorted[indexPath.row]
        cell.detailTextLabel?.text = "Views: \(picViews[views]!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picturesSorted[indexPath.row]
// Challenge 3: Add "Picture (position in the list) of (number of pictures)" as the title of every picture
            vc.pictureTitle = "Picture \(indexPath.row + 1) of \(picturesSorted.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
        
        let picture = pictures[indexPath.row]
        picViews[picture]! += 1
        save()
        tableView.reloadData()
    }
    
    //MARK: - Methods
    
//Challenge 2 Day 22 = Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
    @objc func sharedTapped() {
        let challengeItem = ["Day 22 challenge 2"]
        
        let vc = UIActivityViewController(activityItems: challengeItem, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
//Challenge 1 day 49: 1. Modify project 1 so that it remembers how many times each storm image was shown.
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(picViews) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "picViews")
        } else {
            print("Number not saved")
        }
    }
}

