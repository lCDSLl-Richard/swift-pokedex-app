//
//  ContentView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 29/08/23.
//

import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
  @StateObject var contentViewModel = ContentViewModel()
  @State var searchedPokemon = ""

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Pokedex").font(.largeTitle).bold().padding(.leading, 20)
        if contentViewModel.isLoading {
          ProgressView()
            .progressViewStyle(.circular)

        } else {
          TextField("Search a Pokemon...", text: $searchedPokemon)
            .autocorrectionDisabled()
            .padding(.horizontal, 20)
            .onChange(of: searchedPokemon) { newSearch in
              contentViewModel.searchedPokemon = newSearch
              contentViewModel.filterPokemon()
            }
            .textInputAutocapitalization(.never)

          List(contentViewModel.viewPokemonList) { pokemonBase in
            NavigationLink {
              PokemonDetailView(pokemonBase: pokemonBase)
            } label: {
              HStack {
                WebImage(url: URL(string: pokemonBase.perfil?.sprites.front_default ?? ""))
                  .resizable()
                  .scaledToFit()
                  .frame(width: 48, height: 48, alignment: .center)
                Text(pokemonBase.pokemon.name)
              }
            }
          }
        }
      }
    }.onAppear {
      Task {
        await contentViewModel.getPokemonList()
      }
    }.onTapGesture {
      UIApplication
        .shared
        .sendAction(
          #selector(UIResponder.resignFirstResponder),
          to: nil,
          from: nil,
          for: nil)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
