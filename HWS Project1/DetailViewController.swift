//
//  DetailViewController.swift
//  HWS Project1
//
//  Created by Christopher Koski on 8/31/21.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var selectedImage: String?
  var detailVCTitle: String?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = detailVCTitle
    
    navigationItem.largeTitleDisplayMode = .never
    
    if let imageToLoad = selectedImage {   //checks and unwraps the optional
      imageView.image = UIImage(named: imageToLoad)
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  
}
