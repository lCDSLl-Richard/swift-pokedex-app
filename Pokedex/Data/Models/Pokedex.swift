//
//  Pokedex.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 29/08/23.
//

import Foundation

struct Pokedex: Codable {
  var count: Int
  var results: [Pokemon]
}

struct Pokemon: Codable {
  var name: String
  var url: String
}

struct Perfil: Codable {
  var sprites: Sprite
}

struct Sprite: Codable {
  // swiftlint:disable identifier_name
  var front_default: String
  var back_default: String
  // swiftlint:enable identifier_name
}

struct PokemonBase: Identifiable {
  var id: Int

  var pokemon: Pokemon
  var perfil: Perfil?
}
