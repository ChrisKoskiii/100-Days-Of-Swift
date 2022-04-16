import UIKit

// This will store integer values for each case and they will be automatically assigned
enum Planet: Int {
  case mercury
  case venus
  case earth
  case mars
}

let earth = Planet(rawValue: 2)
let mars = Planet(rawValue: 3)

//If you want, you can assign them a specific vlaue, so they start at 1 for example insteado of 0

//enum Planet: Int {
//  case mercury = 1
//  case venus
//  case earth
//  case mars
//}

