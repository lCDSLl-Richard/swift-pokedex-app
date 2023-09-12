//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import SDWebImageSwiftUI
import SwiftUI

struct PokemonDetailView: View {
  var pokemonBase: PokemonBase

  var body: some View {
    Text(pokemonBase.pokemon.name).font(.largeTitle)
    WebImage(url: URL(string: pokemonBase.perfil?.sprites.front_default ?? ""))
      .resizable()
      .scaledToFit()
      .frame(width: 240, height: 240, alignment: .center)
  }
}
