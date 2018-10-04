import Vapor
import FluentMySQL

struct SubSplice: Codable, CustomStringConvertible {
  var description: String
  var overlap: Bool
  var zSplice: Bool
  var mechFasteners: String
  var longSplice: Bool
  var zTopTemp: Int
  var zBottomTemp: Int
  var zPressWait: Int
  var zPressPressure: Int
  var zPressGlue: String
  var overTopTemp: Int
  var overBottomTemp: Int
  var overPressWait: Int
  var overPressPressure: Int
  var overPressGlue: String
  
  init(description: String, overlap: Bool, zSplice: Bool, mechFasteners: String, longSplice: Bool, zTopTemp: Int, zBottomTemp: Int, zPressWait: Int, zPressPressure: Int, zPressGlue: String, overTopTemp:Int, overBottomTemp: Int, overPressWait: Int, overPressPressure: Int, overPressGlue: String) {
    self.description = description
    self.overlap = overlap
    self.zSplice = zSplice
    self.mechFasteners = mechFasteners
    self.longSplice = longSplice
    self.zTopTemp = zTopTemp
    self.zBottomTemp = zBottomTemp
    self.zPressWait = zPressWait
    self.zPressPressure = zPressPressure
    self.zPressGlue = zPressGlue
    self.overTopTemp = overTopTemp
    self.overBottomTemp = overBottomTemp
    self.overPressWait = overPressWait
    self.overPressPressure = overPressPressure
    self.overPressGlue = overPressGlue
  }
}
