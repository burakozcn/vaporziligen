import Vapor
import FluentMySQL

struct SubFriction: Codable, CustomStringConvertible {
  var description: String
  var onSteelLow: Float
  var onSteelHigh: Float
  var onWoodLow: Float
  var onWoodHigh: Float
  var plasticLow: Float
  var plasticHigh: Float
  
  init(description: String, onSteelLow: Float, onSteelHigh: Float, onWoodLow: Float, onWoodHigh: Float, plasticLow: Float, plasticHigh: Float) {
    self.description = description
    self.onSteelLow = onSteelLow
    self.onSteelHigh = onSteelHigh
    self.onWoodLow = onWoodLow
    self.onWoodHigh = onWoodHigh
    self.plasticLow = plasticLow
    self.plasticHigh = plasticHigh
  }
}
