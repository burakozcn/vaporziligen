import Vapor
import FluentMySQL

struct SubFoodFlame: Codable, CustomStringConvertible {
  var description: String
  var foodApp: Bool
  var flame: Bool
  
  init(description: String, foodApp: Bool, flame: Bool) {
    self.description = description
    self.foodApp = foodApp
    self.flame = flame
  }
}

