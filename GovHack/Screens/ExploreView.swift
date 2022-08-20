//
//  ExporeView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct ExploreView: View {
    @State var featuredListings: [String]
    @State var mapPlaces: [MapLocation]
    @State var selectedPlace: MapLocation?

    init(featuredListings: [String] = [], mapPlaces: [MapLocation] = []) {
        self.featuredListings = featuredListings
        self.mapPlaces = mapPlaces
        self.selectedPlace = nil
    }
    
    private var searchView: some View {
        VStack {
            Text("Tell us whay you need")
                .padding(16)
                .frame(maxWidth: .infinity)
        }.background(Color.gray)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Search")
                searchView.padding(.trailing, 16)
                Divider()
                Text("Map View")
                NormalMapView(
                    places: mapPlaces,
                    selectedPlace: $selectedPlace
                )
                .frame(height: 150)
                .padding(.trailing, 16)
                Divider()
                Text("Featured")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(featuredListings, id: \.self) {
                            FeaturedListingView(image: "office", address: $0)
                        }
                    }
                }
            }.padding(.leading, 16)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(featuredListings: ["1", "2", "3", "4", "5", "6"])
    }
}
