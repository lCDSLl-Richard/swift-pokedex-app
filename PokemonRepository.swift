//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 29/08/23.
//

import Foundation

class Api {
  static let base = "https://pokeapi.co/api/v2"
  
  struct routes {
    static let pokemon = "/pokemon"
  }
}

class PokemonRepository: PokemonAPIProtocol {
  let nService: NetworkAPIService
  
  init(nService: NetworkAPIService = NetworkAPIService.shared) {
    self.nService = nService
  }
  
  func getPokemonList(limit: Int) async -> Pokedex? {
    return await nService
      .getPokedex(
        url: URL(string: "\(Api.base)\(Api.routes.pokemon)")!,
        limit: limit)
  }
  
  func getPokemonInfo(pokemonNumber: Int) async -> Perfil? {
    return await nService
      .getPokemonInfo(
        url: URL(
          string: "\(Api.base)\(Api.routes.pokemon)/\(pokemonNumber)")!)
  }
}
