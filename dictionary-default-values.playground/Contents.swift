import UIKit

// We can provide a defauly value if there isnt anything associated with a specified key in in a dictionary

let favoriteIceCream = [
  "Chris": "Chocolate",
  "Andi": "Chocolate",
  "Mason": "Sweet Potatoes"
]

favoriteIceCream["Chris"]
favoriteIceCream["Kona", default: "Chicken"]

// Providing a default value ensures a value will exist when trying to retrieve at a certain key. 
