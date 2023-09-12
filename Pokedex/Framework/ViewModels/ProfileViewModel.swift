//
//  ProfileViewModel.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
  @Published var email = ""

  var requirement: UserRequirementProtocol

  init(requirement: UserRequirementProtocol = UserRequirement.shared) {
    self.requirement = requirement
  }

  @MainActor
  func getCurrentUser() {
    email = requirement.getCurrentUser() ?? ""
  }

  @MainActor
  func logout() {
    email = ""
    requirement.removeCurrentUser()
  }
}
