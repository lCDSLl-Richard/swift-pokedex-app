//
//  UserRepository.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

protocol UserServiceProtocol {
  func getCurrentUser() -> String?
  func setCurrentUser(_ email: String)
  func removeCurrentUser()
}

class UserRepository: UserServiceProtocol {
  static let shared = UserRepository()
  let service: LocalService

  init(service: LocalService = LocalService.shared) {
    self.service = service
  }

  func getCurrentUser() -> String? {
    return service.getCurrentUser()
  }

  func setCurrentUser(_ email: String) {
    service.setCurrentUser(email)
  }

  func removeCurrentUser() {
    service.removeCurrentUser()
  }
}
