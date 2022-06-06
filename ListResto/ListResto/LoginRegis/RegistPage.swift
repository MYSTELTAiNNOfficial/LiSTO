//
//  RegistPage.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 29/05/22.
//

import SwiftUI

struct RegistPage: View {
    @EnvironmentObject var modelData: ModelData
    @State var email : String = ""
    @State var password : String = ""
    @State var nama : String = ""
    @State var confirmpassword : String = ""
    @State var isKosong = false
    @State var mismatch = false
    
    var body: some View {
        VStack {
            Text("Register")
                .bold()
                .padding(.bottom,20)
            TextField("Nama", text: $nama)
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
            
            TextField("E-Mail", text: $email)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .cornerRadius(5)
                .shadow(radius: 5)
                .frame(width: 250, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.brown, lineWidth: 2)
                )
                .padding(.bottom, 10)
            
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
            
            SecureField("Confirm Password", text: $confirmpassword)
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
            
            if(self.isKosong) {
                Text("Harap diisi semua").foregroundColor(.red)
            }
            
            if(self.mismatch) {
                Text("Password dan Confirm Password tidak sama").foregroundColor(.red)
            }
            
            if(modelData.received){
                Text("Registrasi sukses, silakan kembali ke login page").foregroundColor(.green)
            }
            
            if(!modelData.correct){
                Text("User dengan email yang sama telah terdaftar").foregroundColor(.red)
            }
            
            Button (action: {
                self.modelData.received = false
                self.modelData.correct = true
                self.isKosong = false
                self.mismatch = false
                if (self.email.isEmpty || self.password.isEmpty || self.nama.isEmpty || self.confirmpassword.isEmpty) {
                    self.isKosong = true
                }else{
                    if (self.password == self.confirmpassword){
                        modelData.register(nama: self.nama, email: self.email, password: self.password)
                    }else{
                        self.mismatch = true
                    }
                }
            }){
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(50)
                    .frame(width: .infinity, height: 50)
                    .background(.brown)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RegistPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistPage()
            .environmentObject(ModelData())
    }
}
