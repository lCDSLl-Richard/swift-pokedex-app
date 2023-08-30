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
  @State var displayPokemonList = [PokemonBase]()
  @State var isLoading = false
  @State var searchedPokemon = ""
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text("Pokedex").font(.largeTitle).bold().padding(.leading, 20)
      if isLoading {
        ProgressView()
          .progressViewStyle(.circular)
        
      } else {
        TextField("Search a Pokemon...", text: $searchedPokemon)
          .autocorrectionDisabled()
          .padding(.horizontal, 20)
          .onChange(of: searchedPokemon) { newSearch in
            filterPokemon(newSearch)
          }
          .textInputAutocapitalization(.never)
        List(displayPokemonList) { pokemonBase in
          HStack {
            WebImage(url: URL(string: pokemonBase.perfil?.sprites.front_default ?? ""))
              .resizable()
              .scaledToFit()
              .frame(width: 48, height: 48, alignment: .center)
            Text(pokemonBase.pokemon.name)
            Spacer()
            Image(systemName: "chevron.compact.right").opacity(0.2)
          }.onTapGesture {
            print("touched \(pokemonBase.pokemon.name)")
          }
        }
      }
    }.onAppear {
      Task {
        await getPokemonList()
      }
    }.onTapGesture {
      UIApplication
        .shared
        .sendAction(#selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil)
    }
  }
  
  func getPokemonList() async {
    isLoading = true
    let pokemonRepository = PokemonRepository()
    let result = await pokemonRepository
      .getPokemonList(limit: 100)!
      .results
    
    isLoading = false
    for pokemon in result {
      let pokemonNumber = Int(pokemon.url.split(separator: "/")[5])!
      
      let infoPokemon = await pokemonRepository
        .getPokemonInfo(pokemonNumber: pokemonNumber)
      
      pokemonList
        .append(PokemonBase(id: pokemonNumber,
                            pokemon: pokemon,
                            perfil: infoPokemon))
      if pokemon.name.contains(searchedPokemon)
          || searchedPokemon.isEmpty {
        displayPokemonList
          .append(PokemonBase(id: pokemonNumber,
                              pokemon: pokemon,
                              perfil: infoPokemon))
      }
    }
  }
  
  func filterPokemon(_ name: String) {
    if(name.isEmpty) {
      displayPokemonList = pokemonList
      return
    }
    
    displayPokemonList = pokemonList.filter { pokemon in
      pokemon.pokemon.name.contains(name.lowercased())
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
