import SwiftUI

struct UsersView: View{
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.users, id: \.id) { user in
                    Text(user.name)
                }
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        .padding()
    }
}
