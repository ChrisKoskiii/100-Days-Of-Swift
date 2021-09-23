//
//  ViewController.swift
//  HWS Project 7
//
//  Created by Christopher Koski on 9/9/21.
//

import UIKit

class ViewController: UITableViewController {
  var petitions = [Petition]()
  var sourceWebsite = Website.self
  var filteredPetitions = [Petition]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let urlString: String
    
    //adds search and credits button
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(presentCredits))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filter))
    
    //decides which list will be loaded
    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
      urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }
    
    //where were grabbing the JSON, then parsing it
    if let url = URL(string: urlString) {
      if let data = try? Data(contentsOf: url) {
        parse(json: data)
        filteredPetitions = petitions
        return
      }
    }
    showError()
  }
  
  //Presents the credits
  @objc func presentCredits() {
    let ac = UIAlertController(title: "Credits", message: "This information has been provided by: \(sourceWebsite)", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Okay", style: .default))
    present(ac, animated: true)
    
  }
  
  //filters petitions based on search entered
  @objc func filter() {
    let ac = UIAlertController(title: "Filter petitions by:", message: nil, preferredStyle: .alert)
    ac.addTextField()
    
    let submitAction = UIAlertAction(title: "Search", style: .default) {
      [weak self, weak ac] action in
      guard let search = ac?.textFields?[0].text else { return }
      self?.submitSearch(search)
    }
    
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  //submits the search that the user enters
  func submitSearch(_ search: String) {
    filteredPetitions.removeAll()
    for x in petitions {
      if x.title.contains(search) {
        filteredPetitions.append(x)
      }
    }
    if filteredPetitions.isEmpty {
      notFound()
    }
    tableView.reloadData()
  }
  
  
  //displays an error if nothing to load
  func showError() {
    let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    ac.present(ac, animated: true)
  }
  
  //parses JSON data
  func parse(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      tableView.reloadData()
    }
  }
  
  func notFound() {
    let ac = UIAlertController(title: "Nothing Found", message: "Please try searching again", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPetitions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = filteredPetitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
    
  }
}
