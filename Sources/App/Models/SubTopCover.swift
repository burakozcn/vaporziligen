import Vapor
import FluentMySQL

struct SubTopCover: Codable, CustomStringConvertible {
  var description: String
  var material: String
  var hardness: Int
  var color: String
  var structure: String
  var thickness: Float
  var electrostatic: String
  
  init(description: String, material: String, hardness: Int, color: String, structure: String, thickness: Float, electrostatic: String) {
    self.description = description
    self.material = material
    self.hardness = hardness
    self.color = color
    self.structure = structure
    self.thickness = thickness
    self.electrostatic = electrostatic
  }
}
