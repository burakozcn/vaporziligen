import FluentMySQL
import Vapor
import Leaf
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  /// Register providers first
  try services.register(FluentMySQLProvider())
  try services.register(LeafProvider())
  try services.register(AuthenticationProvider())
  
  /// Register middleware
  var middlewares = MiddlewareConfig() // Create _empty_ middleware config
  middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP
  middlewares.use(FileMiddleware.self)
  middlewares.use(SessionsMiddleware.self)
  services.register(middlewares)
  
  /// Register the configured SQLite database to the database config.
  var databases = DatabasesConfig()
  let mysqlConfig = MySQLDatabaseConfig(hostname: "localhost", port: 3306, username: "zili", password: "ZiliPass", database: "ziligen")
  let database = MySQLDatabase(config: mysqlConfig)
  databases.add(database: database, as: .mysql)
  services.register(databases)
  
  /// Configure migrations
  var migrations = MigrationConfig()
  migrations.add(model: MainCategories.self, database: .mysql)
  migrations.add(model: Token.self, database: .mysql)
  migrations.add(model: User.self, database: .mysql)
  services.register(migrations)
  
  User.Public.defaultDatabase = .mysql
  config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
  
  /// Register routes to the router
  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)
  
  let serverConfigure = NIOServerConfig.default(hostname: "localhost", port: 8080)
  services.register(serverConfigure)

}


