//
//  ContentView.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var goalsManager = GoalsManager.instance
    @StateObject var gridManager = GridManager.instance
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                HomeScreen(geo: geo, goalsManager: goalsManager, gridManager: gridManager)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
