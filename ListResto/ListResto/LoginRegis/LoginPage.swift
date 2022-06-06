//
//  LoginPage.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 29/05/22.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var modelData: ModelData
    @State var email : String = ""
    @State var password : String = ""
    @State var isKosong = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .bold()
                    .padding(.bottom,20)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.brown)
                    TextField("E-Mail", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .frame(width: 250, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.brown, lineWidth: 2)
                        )
                        .padding(.bottom,10)
                }
                HStack {
                    Image(systemName: "key")
                        .foregroundColor(.brown)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .frame(width: 250, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.brown, lineWidth: 2)
                        )
                        .padding(.bottom, 10)
                }
                .padding(.bottom)
                
                if (!modelData.correct) {
                    Text(modelData.userData.message)
                        .foregroundColor(.red)
                }
                
                if(self.isKosong) {
                    Text("Email dan password tidak boleh kosong").foregroundColor(.red)
                }
                
                Button (action: {
                    if (self.email.isEmpty || self.password.isEmpty) {
                        self.isKosong = true
                    }else{
                        modelData.checkLogin(email: self.email, password: self.password)
                    }
                }){
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(.green)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                HStack {
                    Text("Create Account")
                        .font(.subheadline)
                    NavigationLink(destination: RegistPage()) {
                        Text("Here")
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            .padding()
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .environmentObject(ModelData())
    }
}
