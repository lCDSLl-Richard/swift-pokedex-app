//
//  LocalService.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

// swiftlint:disable:next identifier_name
let USER_KEY = "currentUser"

class LocalService {
  static let shared = LocalService()

  func getCurrentUser() -> String? {
    return UserDefaults.standard.string(forKey: USER_KEY)
  }

  func setCurrentUser(_ email: String) {
    UserDefaults.standard.set(email, forKey: USER_KEY)
  }

  func removeCurrentUser() {
    UserDefaults.standard.removeObject(forKey: USER_KEY)
  }
}
