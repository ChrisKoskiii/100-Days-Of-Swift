//
//  ViewController.swift
//  HWS Projects 4-6 Challenge App
//
//  Created by Christopher Koski on 9/8/21.
//

import UIKit

class ViewController: UITableViewController {
  var shoppingList = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Shopping List"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetList))
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
    cell.textLabel?.text = shoppingList[indexPath.row]
    return cell
  }
  
  @objc func addItem() {
    let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
    ac.addTextField()
    
    let submitItem = UIAlertAction(title: "Submit", style: .default) {
      [weak self, weak ac] action in
      guard let item = ac?.textFields?[0].text else { return }
      self?.insertItem(item)
    }
    ac.addAction(submitItem)
    present(ac, animated: true)
    
  }
  func insertItem(_ item: String) {
    shoppingList.insert(item, at: 0)
    
    let indexPath = IndexPath(row:0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
    
  }
  
  @objc func resetList() {
    shoppingList.removeAll()
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == UITableViewCell.EditingStyle.delete {
          shoppingList.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
      }
  }

}

