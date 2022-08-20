//
//  ResultsView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

enum ViewType {
    case list
    case map
}

struct ResultsView: View {
    @State var featuredListings: [PropertyModel] = []
    @State var results: [PropertyModel] = []
    @State var viewType: ViewType = .list
    
    var searchBar: some View {
        HStack {
            Text("What you searched")
            Spacer()
            Image(systemName: "slider.horizontal.3")
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                searchBar.padding(.horizontal, 16)
                HStack {
                    Text("Results: \(results.count)")
                    Spacer()
                    Picker(selection: $viewType) {
                        Text("List").tag(ViewType.list)
                        Text("Map").tag(ViewType.map)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 150)

                }
                .padding(.horizontal, 16)
                Text("Highlighted Listings")
                    .padding(.horizontal, 16)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(featuredListings, id: \.id) {
                            FeaturedListingView(image: "office", address: "\($0.location.streetAddress), \($0.location.suburb)")
                        }
                    }.padding(.leading, 16)
                }
                
                ForEach(results, id: \.id) {
                    ListingView(property: $0)
                }.padding(.horizontal, 16)
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(featuredListings: .mockFeatured, results: .mock)
    }
}
