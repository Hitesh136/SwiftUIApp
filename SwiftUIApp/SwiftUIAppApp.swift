//
//  SwiftUIAppApp.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 05/05/24.
//

import SwiftUI
import Foundation

@main
struct SwiftUIAppApp: App {
    var body: some Scene {
        WindowGroup {
//            MoonShotView()
//            ContentView()
            CupcakeCornerView(order: Order())
        }
    }
}


