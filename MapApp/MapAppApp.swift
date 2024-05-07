//
//  MapAppApp.swift
//  MapApp
//
//  Created by Elouan Savy on 05/05/2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
