import SwiftUI

struct ProfileView: View {
    @State private var showProfile = false
    @State private var showOrders = false
    let uiElements = UIElements()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
            }
            .navigationBarItems(
                leading: Button(action: {
                    showProfile = true
                }) {
                    HStack {
                        uiElements.profileImage(imgUrl: "profile_picture", size: 50)
                    }
                    
                },
                trailing: Button(action: {
                    showOrders = true
                }) {
                    HStack {
                        uiElements.label(text: "Orders", iconName: "cart.circle")
                    }
                }
            )
            .sheet(isPresented: $showProfile) {
                UsersView()
            }
            .sheet(isPresented: $showOrders) {
                OrderView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
