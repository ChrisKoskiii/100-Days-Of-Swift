//
//  Person.swift
//  HWS Project 10
//
//  Created by Christopher Koski on 9/22/21.
//

import UIKit

class Person: NSObject, NSCoding {
  var name: String
  var image: String
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
  }
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
