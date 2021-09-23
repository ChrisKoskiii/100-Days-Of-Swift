//
//  ViewController.swift
//  HWS Project 4
//
//  Created by Christopher Koski on 9/1/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {  //Class A: B, C; A inherits from B, conforms to C protocols
  var webView: WKWebView!
  var progressView: UIProgressView!
  var websites = ["apple.com", "hackingwithswift.com", "reddit.com", "forbidden.com"]
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let url = URL(string: "https://" + websites[0])!
    
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style:.plain, target: self, action: #selector(openTapped))
    
    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
    let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
    
    toolbarItems = [progressButton, spacer, back, forward, refresh]
    navigationController?.isToolbarHidden = false
    
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
  }
  
  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    for website in websites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }
  
  func openPage (action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  func noAccess() {
    let ac = UIAlertController(title: "Access Denied", message: "This website is not allowed", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Return", style: .default, handler: .none))
    present(ac, animated: true)
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    
    if let host = url?.host {
      for website in websites {
        if host.contains(website) {
          decisionHandler(.allow)
          return
        } else if host.contains("forbidden") {
          noAccess()
          decisionHandler(.cancel)
          return
        }
      }
    }
    decisionHandler(.cancel)
  }
}

