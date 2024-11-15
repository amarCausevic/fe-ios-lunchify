import SwiftUI

struct UsersView: View{
    @StateObject private var viewModel = UserListViewModel()
    @StateObject private var orderModel = OrderListViewModel()
    @State private var profileImage: Image? = Image(systemName: "person.circle.fill")
    @State private var isEditing = false
    @State var selection: Int = 0
    var uiElements:UIElements = UIElements()
    
    var body: some View {
        let userInformation: UserDTO
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.users, id: \.id) {user in
                    ProfilePickerView(selection: $selection)
                    HStack{
                        uiElements.profileImage(imgUrl: "profile_picture", size: 100) //TODO constraints
                        uiElements.text(text: user.displayName)
                    }.scrollContentBackground(.hidden).padding([.bottom, .trailing], 60)
                    if(selection == 0){
                        UserInfoView(userDto: user)
                    }
                }.scrollContentBackground(.hidden)
                List(orderModel.orderHistory, id: \.id) {order in
                    if(selection == 1){
                        OrderHistroyView(orderHistoryDTO: order).padding(.top, 0)
                    }
                }.scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            viewModel.loadUsers()
            orderModel.getUserOrderHistoryList() //TODO: Samo klici to kar rabis
        }
        //.padding()
        .edgesIgnoringSafeArea(.all)
        .background(.red)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

struct UserInfoView: View {
    var userDto: UserDTO
    var uiElements:UIElements = UIElements()
    var body: some View {
        uiElements.label(text: userDto.name, iconName: "info.circle")
        uiElements.label(text: userDto.email, iconName: "info.circle")
        uiElements.label(text: userDto.device, iconName: "info.circle")
    }
}

struct ProfilePickerView: View {
    @Binding var selection: Int
    
    var body: some View {
        HStack{
            Picker("", selection: $selection) {
                Text("Profile").tag(0)
                Text("History").tag(1)
            }
            .pickerStyle(.segmented)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 2)
            )
            .frame(width: 234)
        }.scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, alignment: .center)    }
}

struct OrderHistroyView: View {
    var orderHistoryDTO: OrderHistroyDTO
    var uiElements:UIElements = UIElements()
    var body: some View {
        if(orderHistoryDTO.status == "DONE"){
            VStack{
                //TODO: Iterate through meals and in single line display data!
                Text("Order History:").font(.title)
                uiElements.label(text: orderHistoryDTO.timestampCreated, iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.status, iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.meals?.first?.displayName ?? "None", iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.meals?.first?.name ?? "None", iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.meals?.first?.cautionIngredients ?? "None", iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.meals?.first?.ingredients ?? "None", iconName: "figure.walk.triangle")
                uiElements.label(text: orderHistoryDTO.timestampCreated, iconName: "figure.walk.triangle")
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
