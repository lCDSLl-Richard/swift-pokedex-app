import SwiftUI

struct ProfileView: View {
  @StateObject var viewModel = ProfileViewModel()

  let goRoot: () -> Void
  var body: some View {
    VStack(alignment: .center, spacing: 24) {
      Text(viewModel.email)

      Button {
        viewModel.logout()
        goRoot()
      } label: {
        HStack(spacing: 16) {
          Image(systemName: "power")
          Text("Logout")
        }.foregroundColor(.red)
      }
    }.onAppear {
      viewModel.getCurrentUser()
    }
  }
}
