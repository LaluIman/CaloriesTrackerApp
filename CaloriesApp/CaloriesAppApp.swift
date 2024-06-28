//
//  CaloriesAppApp.swift
//  CaloriesApp
//
//  Created by Lalu Iman Abdullah on 28/06/24.
//

import SwiftUI

@main
struct CaloriesAppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
