import UIKit

// Enums are ways of defining groups of related values that makes them easier to use

let result = "failure"
let result2 = "failed"
let result3 = "fail"

// With enums we can define a result type, that can either be "success" or "failure"

enum Result {
  case success
  case failure
}

let result4 = Result.failure

// using enums keeps us from having to use strings each time, which can contain typos

enum weatherCondition {
  case rainy
  case windy
  case sunny
  case snow
}

weatherCondition.rainy
weatherCondition.snow
