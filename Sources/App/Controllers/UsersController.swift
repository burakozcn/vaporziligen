import Vapor
import Crypto
import Authentication

struct UsersController: RouteCollection {
  func boot(router: Router) throws {
    let usersRoute = router.grouped("api", "users")
    usersRoute.post(use: createHandler)
    usersRoute.get(use: getAllHandler)
    usersRoute.get(User.Public.parameter, use: getHandler)
    usersRoute.get(User.parameter, "acronyms", use: getAcronymsHandler)
    
    let basicAuthMiddleware = User.basicAuthMiddleware(using: BCryptDigest())
    let basicAuthGroup = usersRoute.grouped(basicAuthMiddleware)
    basicAuthGroup.post("login", use: loginHandler)
  }
  
  func createHandler(_ req: Request) throws -> Future<User> {
    return try req.content.decode(User.self).flatMap(to: User.self) { user in
      let hasher = try req.make(BCryptDigest.self)
      user.password = try hasher.hash(user.password)
      return user.save(on: req)
    }
  }
  
  func getAllHandler(_ req: Request) throws -> Future<[User.Public]> {
    return User.Public.query(on: req).all()
  }
  
  func getHandler(_ req: Request) throws -> Future<User.Public> {
    return try req.parameters.next(User.Public.self)
  }
  
  func getAcronymsHandler(_ req: Request) throws -> Future<[MainCategories]> {
    return try req.parameters.next(User.self).flatMap(to: [MainCategories].self) { user in
      return try user.mainCategories.query(on: req).all()
    }
  }
  
  func loginHandler(_ req: Request) throws -> Future<Token> {
    let user = try req.requireAuthenticated(User.self)
    let token = try Token.generate(for: user)
    return token.save(on: req)
  }
}
