//
//  MenuView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import SwiftUI

struct MenuView: View {
  let goRoot: () -> Void
  var body: some View {
    TabView {
      ContentView().tabItem {
        Image(systemName: "cricket.ball")
        Text("Pokedex")
      }
      ProfileView(goRoot: goRoot).tabItem {
        Image(systemName: "person")
        Text("Perfil")
      }
    }
  }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    MenuView { () }
  }
}
