import Vapor
import FluentMySQL

struct SubWeightLoad: Codable, CustomStringConvertible {
  var description: String
  var weight: Float
  var breakingLoad: Int
  var workingLoad: Int
  
  init(description: String, weight: Float, breakingLoad: Int, workingLoad: Int) {
    self.description = description
    self.weight = weight
    self.breakingLoad = breakingLoad
    self.workingLoad = workingLoad
  }
}
