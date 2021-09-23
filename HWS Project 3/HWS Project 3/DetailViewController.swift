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
  var imageTitle: String?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = detailVCTitle
    
    navigationItem.largeTitleDisplayMode = .never
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    
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
  
  @objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
      print("No Image Found")
      return
    }
    
    let vc = UIActivityViewController(activityItems: [image, imageTitle!], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //needed for iPad
    present(vc, animated: true)
  }
  
}
