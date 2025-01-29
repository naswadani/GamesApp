//
//  TabBarCustomView.swift
//  Common
//
//  Created by naswakhansa on 04/01/25.
//

import SwiftUI
import Core
import Common
import GameFavorites
import Homepage

struct TabBarCustomView: View {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedTab: Int = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    
    private var aboutButton: some View {
        NavigationLink(destination: AboutView()) {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 20))
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomepageView()
                    .environment(\.managedObjectContext, viewContext)
                    .navigationTitle("Game List")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            aboutButton
                        }
                    }
            }
            .tag(0)
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationView {
                FavoriteGameView()
                    .environment(\.managedObjectContext, viewContext)
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            aboutButton
                        }
                    }
            }
            .tag(1)
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}
