//
//  Person.swift
//  HWS Project 10
//
//  Created by Christopher Koski on 9/22/21.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
