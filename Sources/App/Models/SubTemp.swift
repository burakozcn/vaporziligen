import Vapor
import FluentMySQL

struct SubTemp: Codable, CustomStringConvertible {
  var description: String
  var min: Int
  var max: Int
  
  init(description: String, min: Int, max: Int) {
    self.description = description
    self.min = min
    self.max = max
  }
}
