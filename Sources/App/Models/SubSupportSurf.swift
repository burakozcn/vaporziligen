import Vapor
import FluentMySQL

struct SubSupportSurf: Codable, CustomStringConvertible {
  var description: String
  var sliderBed: Bool
  var rollers: Bool
  var troughedApp: Bool
  
  init(description: String, sliderBed: Bool, rollers: Bool, troughedApp: Bool) {
    self.description = description
    self.sliderBed = sliderBed
    self.rollers = rollers
    self.troughedApp = troughedApp
  }
}
