//
//  ViewController.swift
//  HWS Project1
//
//  Created by Christopher Koski on 8/31/21.
//

import UIKit

class ViewController: UITableViewController {
  
  var pictures = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
    
    let fm = FileManager.default  //used to acces the image files
    let path = Bundle.main.resourcePath!  //where to find the images
    let items = try! fm.contentsOfDirectory(atPath: path) //this will be an array of the files found at path
    
    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
      pictures.sort()
    }
  }
  
  //tells how many rows to return
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  //tells what the cell will contains
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController { //loading DetailViewController
      vc.selectedImage = pictures[indexPath.row] //accessing selectedImage from DetailViewController, setting it to the image in array that was selected
      navigationController?.pushViewController(vc, animated: true)  //push it to the navigation controller
      vc.detailVCTitle = "Image \(indexPath.row + 1) of \(pictures.count)"
      vc.imageTitle = pictures[indexPath.row]
    }
  }
  
  @objc func recommendApp() {
    let vc = UIActivityViewController(activityItems: ["Share App"], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //needed for iPad
    present(vc, animated: true)
    
  }
}

