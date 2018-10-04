import FluentMySQL
import Vapor

struct MidCovers: Codable, CustomStringConvertible {
  var description: String
  var internalCover: String

  init(description: String, internalCover: String, mainID: MainCategories.ID) {
    self.description = description
    self.internalCover = internalCover
  }
}
