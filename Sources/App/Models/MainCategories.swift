import Vapor
import FluentMySQL

final class MainCategories: Codable {
  var id: Int?
  var name: String
  var creatorID: User.ID
  var covers: MidCovers
  var names: MidName
  var PSG: MidPSG
  var date: Date
  var bottomCov: SubBottomCover
  var foodFlame: SubFoodFlame
  var friction: SubFriction
  var length: SubLength
  var profiles: SubProfiles
  var specialChar: SubSpecialChar
  var splice: SubSplice
  var supportSurf: SubSupportSurf
  var temp: SubTemp
  var tension: SubTension
  var topCover: SubTopCover
  var weightLoad: SubWeightLoad
  
  init(name: String, creatorID: User.ID, covers: MidCovers, names: MidName,
       PSG: MidPSG, date: Date, bottomCov: SubBottomCover, foodFlame: SubFoodFlame, friction: SubFriction, length: SubLength, profiles: SubProfiles, specialChar: SubSpecialChar, splice: SubSplice, supportSurf: SubSupportSurf, temp: SubTemp, tension: SubTension, topCover: SubTopCover, weightLoad: SubWeightLoad
    )
  {
    self.name = name
    self.creatorID = creatorID
    self.covers = covers
    self.names = names
    self.PSG = PSG
    self.date = date
    self.bottomCov = bottomCov
    self.foodFlame = foodFlame
    self.friction = friction
    self.length = length
    self.profiles = profiles
    self.specialChar = specialChar
    self.splice = splice
    self.supportSurf = supportSurf
    self.temp = temp
    self.tension = tension
    self.topCover = topCover
    self.weightLoad = weightLoad
  }
}

extension MainCategories: MySQLModel {}
extension MainCategories: Content {}
extension MainCategories: Migration {}
extension MainCategories: Parameter {}


extension MainCategories {
  
  var creator: Parent<MainCategories, User> {
    return parent(\.creatorID)
  }
}
