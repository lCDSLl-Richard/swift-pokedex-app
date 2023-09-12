//
//  LoginView.swift
//  Pokedex
//
//  Created by Ricardo Adolfo Fernández Alvarado on 11/09/23.
//

import SwiftUI

struct LoginView: View {
  @StateObject var viewModel = LoginViewModel()

  let goMenu: () -> Void
  var body: some View {
    VStack(alignment: .center) {
      Spacer().frame(height: 48)

      Text("Pokedex").font(.largeTitle)

      Spacer()

      VStack(spacing: 0) {
        TextField(text: $viewModel.email) {
          Text("Correo Electrónico")
        }.multilineTextAlignment(.center)
          .keyboardType(.emailAddress)
          .padding()
          .font(.title3)
          .textInputAutocapitalization(.never)

        Divider()
      }

      Spacer()

      Button {
        viewModel.setCurrentUser()
        goMenu()
      } label: {
        Text("Acceder")
      }
    }.onAppear {
      viewModel.getCurrentUser()
      if !viewModel.email.isEmpty {
        goMenu()
      }
    }.padding()
      .alert(isPresented: $viewModel.showError) {
        Alert(title: Text("Oops!"), message: Text(viewModel.errorMessage))
      }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView { () }
  }
}
