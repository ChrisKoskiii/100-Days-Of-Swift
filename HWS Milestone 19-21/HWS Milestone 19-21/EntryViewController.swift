//
//  DetailViewController.swift
//  HWS Milestone 19-21
//
//  Created by Christopher Koski on 10/20/21.
//

import UIKit

class EntryViewController: UIViewController {
  
  @IBOutlet var titleField: UITextField!
  @IBOutlet var noteField: UITextView!
  
  public var completion: ((String, String) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleField.becomeFirstResponder()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
  }
  
  @objc func saveNote() {
    if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
      completion?(text, noteField.text)
    }
  }
  
}
