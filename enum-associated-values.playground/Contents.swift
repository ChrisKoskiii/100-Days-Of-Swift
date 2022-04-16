import UIKit

// Associated values let us attach additional information to our enums

enum Activity {
  case bored
  case running(destination: String)
  case talking(topic: String)
  case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")
let running = Activity.running(destination: "Publix")


enum Menu {
  case burger(side: String)
  case soup(salad: Bool)
}

let order = Menu.burger(side: "Fries")
let order2 = Menu.soup(salad: false)


