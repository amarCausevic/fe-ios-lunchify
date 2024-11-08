import SwiftUI

struct UsersView: View{
    @StateObject private var viewModel = UserListViewModel()
    @State private var profileImage: Image? = Image(systemName: "person.circle.fill")
    @State private var isEditing = false
    static let color0 = Color(red: 0/255, green: 255/255, blue: 235/255);
    static let color1 = Color(red: 7/255, green: 58/255, blue: 187/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.users, id: \.id) {user in Text(user.displayName)}.scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        
        .padding()
        .background(LinearGradient(
            gradient: gradient,
            startPoint: .init(x: 0.50, y: 1.00),
            endPoint: .init(x: 0.50, y: 0.00)
        ))
        .edgesIgnoringSafeArea(.all)
    }
}
