//
//  ListRestoApp.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 23/05/22.
//

import SwiftUI

@main
struct ListRestoApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
