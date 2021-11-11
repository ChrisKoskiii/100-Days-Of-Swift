//
//  ViewController.swift
//  HWS Project 28
//
//  Created by Christopher Koski on 11/10/21.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
  @IBOutlet var secret: UITextView!
  
  var doneButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Nothing to see here"
    
    self.doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveSecretMessage))
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    //app will automatically save and hides any text when moving to a background state
    notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
  }

  @IBAction func authenticateTapped(_ sender: Any) {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Identify yourself!"
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
        [weak self] success, authenticationError in
        
        DispatchQueue.main.async {
          if success {
            self?.unlockSecretMessage()
          } else {
            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
          }
        }
      }
    } else {
      let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  }
  
  @objc func adjustForKeyboard(notification: Notification) {
    //NSValue wraps things like cgRect and cgPoint
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    //is size of keyboard reletaive to screen
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    
    //takes into account rotation
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    //checks if were hiding or not
    if notification.name == UIResponder.keyboardWillHideNotification {
      secret.contentInset = .zero
    } else {
      secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }
    
    //scroll view matches the size of the text view
    secret.scrollIndicatorInsets = secret.contentInset
    
    //scrolls to wherever it was selected
    let selectedRange = secret.selectedRange
    secret.scrollRangeToVisible(selectedRange)
  }
  
  func unlockSecretMessage() {
    secret.isHidden = false
    title = "Secret Stuff!"
    
    secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    
    self.navigationItem.rightBarButtonItem = doneButton
  }
  
  @objc func saveSecretMessage() {
    guard secret.isHidden == false else { return }
    
    KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
    secret.resignFirstResponder()
    secret.isHidden = true
    title = "Nothing to see here"
    
    self.navigationItem.rightBarButtonItem = nil
  }
}

