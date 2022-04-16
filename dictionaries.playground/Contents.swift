import UIKit

// Dictioinaries differ from arrays as they let us use keys to identify items. Arrays just use the position. This optimizes their retrieval.

var heights = [
  "Taylor Swift": 1.78,
  "Ed Sheeran": 1.73
]

heights["Taylor Swift"]


var loggedIn = [
  "Chris": true,
  "Andi": false,
  "Mason": true
]

loggedIn["Chris"]!
loggedIn["Andi"]
loggedIn["Mason"]

// Theres no gauranteee a value will exist at a specific key so it returns an optional
