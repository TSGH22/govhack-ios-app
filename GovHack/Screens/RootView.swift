//
//  RootView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

enum Tab: Hashable {
    case explore
    case bookings
    case messages
    case profile
    case more
}

struct RootView: View {
    @State var selection: Tab
    
    init(selection: Tab = .explore) {
        self.selection = selection
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ExploreView().tag(Tab.explore)
                .tabItem {
                    Image(systemName: "map.circle")
                    Text("Explore")
                }
            
            BookingsView().tag(Tab.bookings)
                .tabItem {
                    Image(systemName: "bookmark.circle")
                    Text("Bookings")
                }
            
            MessagesView().tag(Tab.messages)
                .tabItem {
                    Image(systemName: "message.circle")
                    Text("Messages")
                }
            
            ProfileView().tag(Tab.profile)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            
            MoreView().tag(Tab.more)
                .tabItem {
                    Image(systemName: "gear.circle")
                    Text("More")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(selection: .explore)
    }
}
