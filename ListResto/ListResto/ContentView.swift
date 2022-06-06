//
//  ContentView.swift
//  ListResto
//
//  Created by Macbook Pro on 23/05/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var select: Tab = .home
    
    enum Tab {
        case home
        case user
    }
    
    var body: some View {
        if (!modelData.loggedIn) {
            LoginPage()
        } else {
            TabView(selection: $select){
                RestoList()
                    .tag(Tab.home)
                    .tabItem {
                        Label("Dashboard", systemImage: "house")
                    }
                    .onAppear {
                        modelData.readAllResto(id: modelData.userData.id)
                    }
                
                ProfileDetail()
                    .tag(Tab.user)
                    .tabItem{
                        Label("Profile", systemImage: "person")
                    }
                
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}
