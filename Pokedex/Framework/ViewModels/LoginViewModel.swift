//
//  LoginViewModel.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var errorMessage = ""
  @Published var showError = false

  let requirement: UserRequirementProtocol

  init(requirement: UserRequirement = UserRequirement.shared) {
    self.requirement = requirement
  }

  @MainActor
  func getCurrentUser() {
    email = requirement.getCurrentUser() ?? ""
  }

  @MainActor
  func setCurrentUser() {
    if email.isEmpty {
      errorMessage = "Invalid email!"
      showError = true
    } else {
      requirement.setCurrentUser(email)
    }
  }
}
