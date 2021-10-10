//
//  Countries.swift
//  HWD 13-15 Milestone Project
//
//  Created by Christopher Koski on 10/8/21.
//

import Foundation

struct Country: Codable {
  var name: String
  var capital: String
}

//func jsonParse() {
//  let url = Bundle.main.url(forResource: "Countries", withExtension: "json")!
//  let data = try! Data(contentsOf: url)
//  let countries = try! JSONDecoder().decode([Country].self, from: data)
//  for country in countries {
//    let name = country.name
//    let capital = country.capital
//    print("=======",name, capital,"=======")
//  }
//}


