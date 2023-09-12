//
//  PokemonListRequirement.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import Foundation

protocol PokemonListRequirementProtocol {
  func getPokemonList(limit: Int) async -> Pokedex?
}

class PokemonListRequirement: PokemonListRequirementProtocol {
  let dataRepository: PokemonRepository
  static let shared = PokemonListRequirement()

  init(dataRepository: PokemonRepository = PokemonRepository.shared) {
    self.dataRepository = dataRepository
  }

  func getPokemonList(limit: Int) async -> Pokedex? {
    return await dataRepository.getPokemonList(limit: limit)
  }
}
