//
//  ContentViewModel.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 01/09/23.
//

import Foundation

class ContentViewModel: ObservableObject {
  var pokemonListRequirement: PokemonListRequirementProtocol
  var pokemonInfoRequirement: PokemonInfoRequirementProtocol

  var pokemonList = [PokemonBase]()
  @Published var viewPokemonList = [PokemonBase]()
  @Published var searchedPokemon = ""
  @Published var isLoading = false

  init(
    pokemonListRequirement: PokemonListRequirementProtocol = PokemonListRequirement.shared,
    pokemonInfoRequirement: PokemonInfoRequirementProtocol = PokemonInfoRequirement.shared
  ) {
    self.pokemonListRequirement = pokemonListRequirement
    self.pokemonInfoRequirement = pokemonInfoRequirement
  }

  @MainActor
  func getPokemonList() async {
    isLoading = true
    let result = await pokemonListRequirement.getPokemonList(limit: 100)!.results
    isLoading = false

    for pokemon in result {
      let pokemonNumber = Int(pokemon.url.split(separator: "/")[5])!

      let infoPokemon =
        await pokemonInfoRequirement
        .getPokemonInfo(pokemonNumber: pokemonNumber)

      pokemonList
        .append(
          PokemonBase(
            id: pokemonNumber,
            pokemon: pokemon,
            perfil: infoPokemon))

      if pokemon.name.contains(searchedPokemon)
        || searchedPokemon.isEmpty {
        viewPokemonList
          .append(
            PokemonBase(
              id: pokemonNumber,
              pokemon: pokemon,
              perfil: infoPokemon))
      }
    }
  }

  func filterPokemon() {
    if searchedPokemon.isEmpty {
      viewPokemonList = pokemonList
      return
    }

    viewPokemonList = pokemonList.filter { pokemon in
      pokemon.pokemon.name.contains(searchedPokemon.lowercased())
    }
  }
}
