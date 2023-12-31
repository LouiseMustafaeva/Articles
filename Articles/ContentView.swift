//
//  ContentView.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case business
        case sport
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NewsScene(screenType: .home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            BusinessScene(screenType: .business)
                .tabItem {
                    Label("Business", systemImage: "briefcase")
                }
            
            SportScene(screenType: .sport)
                .tabItem {
                    Label("Sport", systemImage: "basketball.fill")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
