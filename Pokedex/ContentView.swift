//
//  ContentView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 29/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
  @State var pokemonList = [PokemonBase]()
  var body: some View {
    
    List(pokemonList) { pokemonBase in
      HStack {
        WebImage(url: URL(string: pokemonBase.perfil?.sprites.front_default ?? ""))
          .resizable()
          .scaledToFit()
          .frame(width: 48, height: 48, alignment: .center)
        Text(pokemonBase.pokemon.name)
      }
    }.onAppear {
      Task {
        await getPokemonList()
      }
    }
  }
  
  func getPokemonList() async {
    let pokemonRepository = PokemonRepository()
    let result = await pokemonRepository
      .getPokemonList(limit: 100)!
      .results
    
    var tempPokemonList = [PokemonBase]()
    for pokemon in result {
      let pokemonNumber = Int(pokemon.url.split(separator: "/")[5])!
      
      let infoPokemon = await pokemonRepository
        .getPokemonInfo(pokemonNumber: pokemonNumber)
      
      let tempPokemon = PokemonBase(id: pokemonNumber, pokemon: pokemon, perfil: infoPokemon)
      
      tempPokemonList.append(tempPokemon)
    }
    pokemonList = tempPokemonList
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
