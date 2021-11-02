//
//  ViewController.swift
//  HWS Milestone 22-24
//
//  Created by Christopher Koski on 10/30/21.
//

import UIKit

extension UIView {
  func bounceOut(Duration: TimeInterval) {
    UIView.animate(withDuration: Duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
      self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    })
  }
  func bounceIn(Duration: TimeInterval) {
    UIView.animate(withDuration: Duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
      self.self.transform = CGAffineTransform(scaleX: 1, y: 1)
    })
  }
}

extension Int {
  func times() {
    for _ in 0..<self {
      print("Hello!")
    }
  }
}

extension Array where Element: Comparable {
  mutating func remove(item: Element) {
    if let location = self.firstIndex(of: item) {
      self.remove(at: location)
    }
  }
}


class ViewController: UIViewController {
  
  @IBOutlet var testView: UIView!
  var numbers = [1, 2, 3, 4, 5]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    5.times()
    

    numbers.remove(item: 3)
    print(numbers)
    
  }
  
  @IBAction func bounceOutTapped(_ sender: UIButton) {
    testView!.bounceOut(Duration: 1)
  }
  
  @IBAction func bounceInTapped(_ sender: Any) {
    testView!.bounceIn(Duration: 1)
  }
}
