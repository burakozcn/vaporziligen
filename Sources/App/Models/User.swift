import Foundation
import Vapor
import FluentMySQL
import Authentication

final class User: Codable {
  var id: UUID?
  var name: String
  var username: String
  var password: String
  var email: String
  var country: String
  var company: String
  var phoneNumber: String
  var admin: Bool
  
  init(name: String, username: String, password: String, email: String, country: String, company: String, phoneNumber: String, admin: Bool) {
    self.name = name
    self.username = username
    self.password = password
    self.email = email
    self.country = country
    self.company = company
    self.phoneNumber = phoneNumber
    self.admin = admin
  }
  
  final class Public: Codable {
    var id: UUID?
    var name: String
    var username: String
    
    init(name: String, username: String) {
      self.name = name
      self.username = username
    }
  }
}
  
extension User: MySQLUUIDModel { }
extension User: Migration { }
extension User: Content { }
extension User: Parameter { }

extension User.Public : MySQLUUIDModel {
  static let entity = User.entity
}
extension User.Public : Content { }
extension User.Public : Parameter { }

extension User {
  var mainCategories: Children<User, MainCategories> {
    return children(\.creatorID)
  }
}

extension User: BasicAuthenticatable {
  static let usernameKey: UsernameKey = \User.username
  static let passwordKey: PasswordKey = \User.password
}

extension User: TokenAuthenticatable {
  typealias TokenType = Token
}

extension User: PasswordAuthenticatable { }
extension User: SessionAuthenticatable { }
