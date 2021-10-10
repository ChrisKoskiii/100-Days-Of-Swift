//
//  ViewController.swift
//  HWD 13-15 Milestone Project
//
//  Created by Christopher Koski on 10/8/21.
//

import UIKit

class ViewController: UITableViewController {
  
  var countries = [Country]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      let url = Bundle.main.url(forResource: "Countries", withExtension: "json")!
      let data = try Data(contentsOf: url)
      let parsedCountries = try JSONDecoder().decode([Country].self, from: data)
      countries = parsedCountries
      tableView.reloadData()
      
    }
    catch {
      print(error)
    }
    
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let country = countries[indexPath.row]
    cell.textLabel?.text = country.name
    cell.detailTextLabel?.text = country.capital
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "mySegue" , sender: countries[indexPath.row])
  }
  
}
