import Vapor
import FluentMySQL

struct SubProfiles: Codable, CustomStringConvertible {
  var description: String
  var top: Bool
  var bottom: Bool
  var sideWall: Bool
  
  init(description: String, top: Bool, bottom: Bool, sideWall: Bool) {
    self.description = description
    self.top = top
    self.bottom = bottom
    self.sideWall = sideWall
  }
}
