import Vapor
import FluentMySQL

struct SubTension: Codable, CustomStringConvertible {
  var description: String
  var numberOfPlies: Int
  var material: String
  var structure: String
  
  init(description: String, numberOfPlies: Int, material: String, structure: String) {
    self.description = description
    self.numberOfPlies = numberOfPlies
    self.material = material
    self.structure = structure
  }
}
