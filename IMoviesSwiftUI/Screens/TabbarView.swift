//
//  TabbarView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeListView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                FavoriteListView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
            }
        }
    }
}
