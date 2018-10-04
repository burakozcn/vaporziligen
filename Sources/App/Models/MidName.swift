import FluentMySQL
import Vapor

struct MidName: Codable, CustomStringConvertible {
  var description: String
  var stockNum: String
  var type: String
  
  init(description: String, stockNum: String, type: String) {
    self.description = description
    self.stockNum = stockNum
    self.type = type
  }
}
