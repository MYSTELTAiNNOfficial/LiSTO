//
//  ProfileDetail.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 29/05/22.
//

import SwiftUI

struct ProfileDetail: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .font(.system(size: 150))
                .padding(.bottom)
            Text("Hi, \(modelData.userData.user)!")
        }
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetail()
            .environmentObject(ModelData())
    }
}
