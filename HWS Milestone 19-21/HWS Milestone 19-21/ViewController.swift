//
//  ViewController.swift
//  HWS Milestone 19-21
//
//  Created by Christopher Koski on 10/20/21.
//

import UIKit

class ViewController: UITableViewController {
  
  @IBOutlet var table: UITableView!
  
  var modelNote: [(title: String, note: String)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Notes"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelNote.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = modelNote[indexPath.row].title
    cell.detailTextLabel?.text = modelNote[indexPath.row].note
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let model = modelNote[indexPath.row]
    
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? NoteViewController else { return }
    
    vc.navigationItem.largeTitleDisplayMode = .never
    vc.title = "Note"
    vc.noteTitle = model.title
    vc.note = model.note
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func createNote() {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "Entry") as? EntryViewController else { return }
    vc.title = "New Note"
    vc.navigationItem.largeTitleDisplayMode = .never
    vc.completion = { noteTitle, note in
      self.navigationController?.popToRootViewController(animated: true)
      self.modelNote.append((title: noteTitle, note: note))
      self.table.isHidden = false
      
      self.table.reloadData()
      
    }
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func deleteNote() {
    
  }
  
}

