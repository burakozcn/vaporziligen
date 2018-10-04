import Vapor
import FluentMySQL

struct SubSpecialChar: Codable, CustomStringConvertible {
  var description: String
  var fdaFood: Bool
  var euFood: Bool
  var animalOil: Bool
  var vegetalOil: Bool
  var mineralOil: Bool
  var limitedRestoAn: Bool
  var excellentAbrasionRes: Bool
  var cutRes: Bool
  var lowFric: Bool
  var silentFab: Bool
  var atex: Bool
  
  init(description: String, fdaFood: Bool, euFood: Bool, animalOil: Bool, vegetalOil: Bool, mineralOil: Bool, limitedRestoAn: Bool, excellentAbrasionRes: Bool, cutRes: Bool, lowFric: Bool, silentFab: Bool, atex: Bool) {
    self.description = description
    self.fdaFood = fdaFood
    self.euFood = euFood
    self.animalOil = animalOil
    self.vegetalOil = vegetalOil
    self.mineralOil = mineralOil
    self.limitedRestoAn = limitedRestoAn
    self.excellentAbrasionRes = excellentAbrasionRes
    self.cutRes = cutRes
    self.lowFric = lowFric
    self.silentFab = silentFab
    self.atex = atex
  }
}
