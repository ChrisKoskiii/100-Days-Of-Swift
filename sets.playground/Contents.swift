import UIKit

// Items are stored in a random order
// All items must be unique

let colors = Set(["red", "green", "blue"])

// Because they are unordered, you cant access items via index

let colors2 = Set(["red", "green", "blue", "red", "green"])

// Duplicate items are ignored

let days = [("sunday", "monday", "tuesday", "wednesday", "monday", "sunday")]


// Because order doesnt matter, they are optimized for fast retrieval. Arrays will check every item before returning.

// We use sets for times when we want to know "Does this item exist?"
