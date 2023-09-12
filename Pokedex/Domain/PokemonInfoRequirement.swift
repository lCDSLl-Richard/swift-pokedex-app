//
//  PokemonInfoRequirement.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

protocol PokemonInfoRequirementProtocol {
  func getPokemonInfo(pokemonNumber: Int) async -> Perfil?
}

class PokemonInfoRequirement: PokemonInfoRequirementProtocol {
  let dataRepository: PokemonRepository
  static let shared = PokemonInfoRequirement()

  init(dataRepository: PokemonRepository = PokemonRepository.shared) {
    self.dataRepository = dataRepository
  }

  func getPokemonInfo(pokemonNumber: Int) async -> Perfil? {
    return await dataRepository.getPokemonInfo(pokemonNumber: pokemonNumber)
  }
}
