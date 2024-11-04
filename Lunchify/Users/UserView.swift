//
//  UserView.swift
//  Lunchify
//
//  Created by Amar Causevic on 4. 11. 24.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel = UserViewModel()
    var body: some View {
        Spacer()
//        VStack{
//            TextField(
//                "Login.UsernameField.Title".localized,
//                text: $viewModel.username
//            )
//            .autocapitalization(.none)
//            .disableAutocorrection(true)
//            .padding(.top, 20)
//            
//            Divider()
//            
//            SecureField(
//                "Login.PasswordField.Title".localized,
//                text: $viewModel.password
//            )
//            .padding(.top, 20)
//            
//            Divider()
//        }
    }
}

#Preview {
    UserView()
}
