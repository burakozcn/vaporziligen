import FluentMySQL
import Vapor

struct MidPSG: Codable, CustomStringConvertible {
  var description: String
  var generalInfo: String
  
  init(description:String, generalInfo: String) {
    self.description = description
    self.generalInfo = generalInfo
  }
}
