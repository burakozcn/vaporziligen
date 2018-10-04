import Vapor
import Fluent

struct MainCatController: RouteCollection {
  
  func boot(router: Router) throws {
    let mainCatRoute = router.grouped("api", "maincategories")
    mainCatRoute.get(use: getAllHandler)
    mainCatRoute.get(MainCategories.parameter, use: getHandler)
    mainCatRoute.get(MainCategories.parameter, "creator", use: getCreatorHandler)
    
    let tokenAuthMiddleware = User.tokenAuthMiddleware()
    let tokenAuthGroup = mainCatRoute.grouped(tokenAuthMiddleware)
    tokenAuthGroup.post(use: createHandler)
    tokenAuthGroup.delete(MainCategories.parameter, use: deleteHandler)
    tokenAuthGroup.put(MainCategories.parameter, use: updateHandler)
  }
  
  func getAllHandler(_ req: Request) throws -> Future<[MainCategories]> {
    return MainCategories.query(on: req).all()
  }
  
  func getHandler(_ req: Request) throws -> Future<MainCategories> {
    return try req.parameters.next(MainCategories.self)
  }
  
  func createHandler(_ req: Request) throws -> Future<MainCategories> {
    return try req.content.decode(MainCatCreateData.self).flatMap(to: MainCategories.self) { mainCatData in
      let user = try req.requireAuthenticated(User.self)
      let mainCat = try MainCategories(name: mainCatData.name, creatorID: user.requireID(),
                                       covers: MidCovers(description: mainCatData.name, internalCover: mainCatData.internalCover, mainID: mainCatData.id),
                                       names: MidName(description: mainCatData.name, stockNum: mainCatData.stockNum, type: mainCatData.type),
                                       PSG: MidPSG(description: mainCatData.name, generalInfo: mainCatData.generalInfo),
                                       date: mainCatData.updateDate,
                                       bottomCov: SubBottomCover(description: mainCatData.name, material: mainCatData.botMaterial, hardness: mainCatData.botHardness, color: mainCatData.botColor, structure: mainCatData.botStructure, thickness: mainCatData.botThickness, electrostatic: mainCatData.botElectrostatic),
                                       foodFlame: SubFoodFlame(description: mainCatData.name, foodApp: mainCatData.foodApp, flame: mainCatData.flame),
                                       friction: SubFriction(description: mainCatData.name, onSteelLow: mainCatData.onSteelLow, onSteelHigh: mainCatData.onSteelHigh, onWoodLow: mainCatData.onWoodLow, onWoodHigh: mainCatData.onWoodHigh, plasticLow: mainCatData.plasticLow, plasticHigh: mainCatData.plasticHigh),
                                       length: SubLength(description: mainCatData.name, totalThick: mainCatData.totalThick, tolerance: mainCatData.tolerance, minDrum: mainCatData.minDrum, prodWidth: mainCatData.prodWidth),
                                       profiles: SubProfiles(description: mainCatData.name, top: mainCatData.top, bottom: mainCatData.bottom, sideWall: mainCatData.sideWall),
                                       specialChar: SubSpecialChar(description: mainCatData.name, fdaFood: mainCatData.fdaFood, euFood: mainCatData.euFood, animalOil: mainCatData.animalOil, vegetalOil: mainCatData.vegetalOil, mineralOil: mainCatData.mineralOil, limitedRestoAn: mainCatData.limitedRestoAn, excellentAbrasionRes: mainCatData.excellentAbrasionRes, cutRes: mainCatData.cutRes, lowFric: mainCatData.lowFric, silentFab: mainCatData.silentFab, atex: mainCatData.atex),
                                       splice: SubSplice(description: mainCatData.name, overlap: mainCatData.overlap, zSplice: mainCatData.zSplice, mechFasteners: mainCatData.mechFasteners, longSplice: mainCatData.longSplice, zTopTemp: mainCatData.zTopTemp, zBottomTemp: mainCatData.zBottomTemp, zPressWait: mainCatData.zPressWait, zPressPressure: mainCatData.zPressPressure, zPressGlue: mainCatData.zPressGlue, overTopTemp: mainCatData.overTopTemp, overBottomTemp: mainCatData.overBottomTemp, overPressWait: mainCatData.overPressWait, overPressPressure: mainCatData.overPressPressure, overPressGlue: mainCatData.overPressGlue),
                                       supportSurf: SubSupportSurf(description: mainCatData.name, sliderBed: mainCatData.sliderBed, rollers: mainCatData.rollers, troughedApp: mainCatData.troughedApp),
                                       temp: SubTemp(description: mainCatData.name, min: mainCatData.min, max: mainCatData.max),
                                       tension: SubTension(description: mainCatData.name, numberOfPlies: mainCatData.numberOfPlies, material: mainCatData.tensMaterial, structure: mainCatData.tensStructure),
                                       topCover: SubTopCover(description: mainCatData.name, material: mainCatData.topMaterial, hardness: mainCatData.topHardness, color: mainCatData.topColor, structure: mainCatData.topStructure, thickness: mainCatData.topThickness, electrostatic: mainCatData.topElectrostatic),
                                       weightLoad: SubWeightLoad(description: mainCatData.name, weight: mainCatData.weight, breakingLoad: mainCatData.breakingLoad, workingLoad: mainCatData.workingLoad)
      )
      return mainCat.save(on: req)
    }
  }
  
  func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
    return try req.parameters.next(MainCategories.self).flatMap(to: HTTPStatus.self) { mainCat in
      return mainCat.delete(on: req).transform(to: HTTPStatus.noContent)
    }
  }
  
  
  func updateHandler(_ req: Request) throws -> Future<MainCategories> {
    return try flatMap(to: MainCategories.self, req.parameters.next(MainCategories.self), req.content.decode(MainCatCreateData.self)) { mainCat, mainCatData in
      mainCat.name = mainCatData.name
      mainCat.covers.internalCover = mainCatData.internalCover
      mainCat.names.stockNum = mainCatData.stockNum
      mainCat.names.type = mainCatData.type
      mainCat.PSG.generalInfo = mainCatData.generalInfo
      mainCat.date = mainCatData.updateDate
      mainCat.bottomCov.material = mainCatData.botMaterial
      mainCat.bottomCov.hardness = mainCatData.botHardness
      mainCat.bottomCov.color = mainCatData.botColor
      mainCat.bottomCov.structure = mainCatData.botStructure
      mainCat.bottomCov.thickness = mainCatData.botThickness
      mainCat.bottomCov.electrostatic = mainCatData.botElectrostatic
      mainCat.foodFlame.foodApp = mainCatData.foodApp
      mainCat.foodFlame.flame = mainCatData.flame
      mainCat.friction.onSteelLow = mainCatData.onSteelLow
      mainCat.friction.onSteelHigh = mainCatData.onSteelHigh
      mainCat.friction.onWoodLow = mainCatData.onWoodLow
      mainCat.friction.onWoodHigh = mainCatData.onWoodHigh
      mainCat.friction.plasticLow = mainCatData.plasticLow
      mainCat.friction.plasticHigh = mainCatData.plasticHigh
      mainCat.length.totalThick = mainCatData.totalThick
      mainCat.length.tolerance = mainCatData.tolerance
      mainCat.length.minDrum = mainCatData.minDrum
      mainCat.length.prodWidth = mainCatData.prodWidth
      mainCat.profiles.top = mainCatData.top
      mainCat.profiles.bottom = mainCatData.bottom
      mainCat.profiles.sideWall = mainCatData.sideWall
      mainCat.specialChar.fdaFood = mainCatData.fdaFood
      mainCat.specialChar.euFood = mainCatData.euFood
      mainCat.specialChar.animalOil = mainCatData.animalOil
      mainCat.specialChar.vegetalOil = mainCatData.vegetalOil
      mainCat.specialChar.mineralOil = mainCatData.mineralOil
      mainCat.specialChar.limitedRestoAn = mainCatData.limitedRestoAn
      mainCat.specialChar.excellentAbrasionRes = mainCatData.excellentAbrasionRes
      mainCat.specialChar.cutRes = mainCatData.cutRes
      mainCat.specialChar.lowFric = mainCatData.lowFric
      mainCat.specialChar.silentFab = mainCatData.silentFab
      mainCat.specialChar.atex = mainCatData.atex
      mainCat.splice.overlap = mainCatData.overlap
      mainCat.splice.zSplice = mainCatData.zSplice
      mainCat.splice.mechFasteners = mainCatData.mechFasteners
      mainCat.splice.longSplice = mainCatData.longSplice
      mainCat.splice.zTopTemp = mainCatData.zTopTemp
      mainCat.splice.zBottomTemp = mainCatData.zBottomTemp
      mainCat.splice.zPressWait = mainCatData.zPressWait
      mainCat.splice.zPressPressure = mainCatData.zPressPressure
      mainCat.splice.zPressGlue = mainCatData.zPressGlue
      mainCat.splice.overTopTemp = mainCatData.overTopTemp
      mainCat.splice.overBottomTemp = mainCatData.overBottomTemp
      mainCat.splice.overPressWait = mainCatData.overPressWait
      mainCat.splice.overPressPressure = mainCatData.overPressPressure
      mainCat.splice.overPressGlue = mainCatData.overPressGlue
      mainCat.supportSurf.sliderBed = mainCatData.sliderBed
      mainCat.supportSurf.rollers = mainCatData.rollers
      mainCat.supportSurf.troughedApp = mainCatData.troughedApp
      mainCat.temp.min = mainCatData.min
      mainCat.temp.max = mainCatData.max
      mainCat.tension.numberOfPlies = mainCatData.numberOfPlies
      mainCat.tension.material = mainCatData.tensMaterial
      mainCat.tension.structure = mainCatData.tensStructure
      mainCat.topCover.material = mainCatData.topMaterial
      mainCat.topCover.hardness = mainCatData.topHardness
      mainCat.topCover.color = mainCatData.topColor
      mainCat.topCover.structure = mainCatData.topStructure
      mainCat.topCover.thickness = mainCatData.topThickness
      mainCat.topCover.electrostatic = mainCatData.topElectrostatic
      mainCat.weightLoad.weight = mainCatData.weight
      mainCat.weightLoad.breakingLoad = mainCatData.breakingLoad
      mainCat.weightLoad.workingLoad = mainCatData.workingLoad
      mainCat.creatorID = try req.requireAuthenticated(User.self).requireID()
      return mainCat.save(on: req)
    }
  }
  
  func getCreatorHandler(_ req: Request) throws -> Future<User> {
    return try req.parameters.next(MainCategories.self).flatMap(to: User.self) { mainCat in return mainCat.creator.get(on: req)
    }
  }
  
}

struct SubFFCreateData: Content {
  let name: String
  let id: Int
  let foodApp: Bool
  let flame: Bool
}

struct MainCatCreateData: Content {
  let name: String
  let internalCover: String
  let id: Int
  let stockNum: String
  let type: String
  let generalInfo: String
  let updateDate: Date
  let botMaterial: String
  let botHardness: Int
  let botColor: String
  let botStructure: String
  let botThickness: Float
  let botElectrostatic: String
  let foodApp: Bool
  let flame: Bool
  let onSteelLow: Float
  let onSteelHigh: Float
  let onWoodLow: Float
  let onWoodHigh: Float
  let plasticLow: Float
  let plasticHigh: Float
  let totalThick: Float
  let tolerance: Float
  let minDrum: Int
  let prodWidth: Int
  let top: Bool
  let bottom: Bool
  let sideWall: Bool
  let fdaFood: Bool
  let euFood: Bool
  let animalOil: Bool
  let vegetalOil: Bool
  let mineralOil: Bool
  let limitedRestoAn: Bool
  let excellentAbrasionRes: Bool
  let cutRes: Bool
  let lowFric: Bool
  let silentFab: Bool
  let atex: Bool
  let overlap: Bool
  let zSplice: Bool
  let mechFasteners: String
  let longSplice: Bool
  let zTopTemp: Int
  let zBottomTemp: Int
  let zPressWait: Int
  let zPressPressure: Int
  let zPressGlue: String
  let overTopTemp:Int
  let overBottomTemp: Int
  let overPressWait: Int
  let overPressPressure: Int
  let overPressGlue: String
  let sliderBed: Bool
  let rollers: Bool
  let troughedApp: Bool
  let min: Int
  let max: Int
  let numberOfPlies: Int
  let tensMaterial: String
  let tensStructure: String
  let topMaterial: String
  let topHardness: Int
  let topColor: String
  let topStructure: String
  let topThickness: Float
  let topElectrostatic: String
  let weight: Float
  let breakingLoad: Int
  let workingLoad: Int
}

