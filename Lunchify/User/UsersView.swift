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
                List(viewModel.users, id: \.id) {user in
                    HStack{
                        Image("profile_picture")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .background(Color.clear)
                        Text(user.displayName)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }.scrollContentBackground(.hidden)
                }
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
