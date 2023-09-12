//
//  CoordinatorView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import FlowStacks
import SwiftUI

struct CoordinatorView: View {

  enum Screens {
    case login
    case menu
  }

  @State var routes: Routes<Screens> = [.root(.login)]

  var body: some View {
    Router($routes) { screen, _ in
      switch screen {
      case .login:
        LoginView(goMenu: { routes.presentCover(.menu) })

      case .menu:
        MenuView(goRoot: { routes.presentCover(.login) })
      }
    }
  }

  private func goRoot() {
    Task { @MainActor in
      await $routes.withDelaysIfUnsupported {
        $0.goBackToRoot()
      }
    }
  }
}

struct CoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    CoordinatorView()
  }
}
