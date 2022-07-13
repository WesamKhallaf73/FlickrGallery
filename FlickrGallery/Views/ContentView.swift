//
//  ContentView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    let appearance: UITabBarAppearance = UITabBarAppearance()
    init() {
        appearance.backgroundColor = UIColor(Color( red: 0.1, green: 0.1, blue: 0.2))
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            
           
            InterestingView()
                .tabItem {
                    Label("Interresting" , systemImage: "circle.grid.3x3.circle.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search" , systemImage: "magnifyingglass")
                }
            FeaturedView()
                .tabItem {
                    Label("Featured" , systemImage: "star.circle.fill")
                }
           
            HotTagView()
                .tabItem {
                    Label("Hot" , systemImage: "flame.fill")
                        .foregroundColor(.red)
                }
            
        }.background(.gray)
        //.environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
