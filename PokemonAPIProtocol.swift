//
//  PokemonAPIProtocol.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 29/08/23.
//

import Foundation

protocol PokemonAPIProtocol {
  func getPokemonList(limit: Int) async -> Pokedex?
  func getPokemonInfo(pokemonNumber: Int) async -> Perfil?
}
