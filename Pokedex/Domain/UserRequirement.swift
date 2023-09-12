//
//  UserRequirement.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

protocol UserRequirementProtocol {
  func getCurrentUser() -> String?
  func setCurrentUser(_ email: String)
  func removeCurrentUser()
}

class UserRequirement: UserRequirementProtocol {
  static let shared = UserRequirement()
  let repository: UserRepository

  init(repository: UserRepository = UserRepository.shared) {
    self.repository = repository
  }

  func getCurrentUser() -> String? {
    return repository.getCurrentUser()
  }

  func setCurrentUser(_ email: String) {
    repository.setCurrentUser(email)
  }

  func removeCurrentUser() {
    repository.removeCurrentUser()
  }
}
