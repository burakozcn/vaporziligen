import Vapor
import FluentMySQL

struct SubLength: Codable, CustomStringConvertible {
  var description: String
  var totalThick: Float
  var tolerance: Float
  var minDrum: Int
  var prodWidth: Int
  
  init(description: String, totalThick: Float, tolerance: Float, minDrum: Int, prodWidth: Int) {
    self.description = description
    self.totalThick = totalThick
    self.tolerance = tolerance
    self.minDrum = minDrum
    self.prodWidth = prodWidth
  }
}
