//
//  ExporeView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    @State var selectedPlace: MapLocation?
    @State var filtersIsPresented: Bool = false
    @State var searchModel: SearchRequestModel?
    @State var showResults: Bool = false
    @ObservedObject var viewModel = ExploreViewModel()

    init(viewModel: ExploreViewModel = ExploreViewModel()) {
        self.selectedPlace = nil
        self.viewModel = viewModel
    }
    
    private var searchView: some View {
        VStack {
            Text("What space are you looking for?")
                .frame(maxWidth: .infinity)
                .font(.urbanistHeading5.bold())
                .padding(.bottom, 24)
            HStack {
                Spacer()
                Text("Start searching")
                    .font(.urbanistBodyBoldXLarge)
                Image(systemName: "magnifyingglass")
                Spacer()
            }
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 100).fill(Color.urbanPrimary500))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 28).fill(Color.white).shadow(radius: 2))
        .onTapGesture {
            filtersIsPresented = true
        }
        .onAppear {
            viewModel.loadContent()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("ownerPicture")
                        .resizable()
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Good Morning 👋")
                            .font(.urbanistBodyMedium)
                        Text("Andrew Ainsley")
                            .font(.urbanistHeading6.bold())
                    }
                    Spacer()
                    Image("notifications")
                }
                .padding(.horizontal, 24)
                
                Group {
                    searchView
                        .padding(.top, 24)
                        .padding(.trailing, 24)
                    ScrollView(.horizontal) {
                        HStack {
                            ToggleButton(text: "All", isSelected: .constant(true))
                            ToggleButton(text: "Hot Desks", isSelected: .constant(false))
                            ToggleButton(text: "Meeting Room", isSelected: .constant(false))
                            ToggleButton(text: "Studio", isSelected: .constant(false))
                            ToggleButton(text: "Others", isSelected: .constant(false))
                        }
                    }.padding(.top, 24)
                    HStack(alignment: .center) {
                        Text("Nearby Spaces (12)")
                            .font(.urbanistHeading5.bold())
                        Spacer()
                        Text("See All")
                            .font(.urbanistBodyLarge.bold())
                            .foregroundColor(.urbanPrimary500)
                    }
                    .padding(.trailing, 24)
                    .padding(.top, 24)
                    NormalMapView(
                        places: viewModel.mapPlaces,
                        selectedPlace: $selectedPlace,
                        displayedRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400))
                    )
                    .frame(height: 150)
                    .padding(.trailing, 16)
                    
                    HStack(alignment: .center) {
                        Text("'Green' Spaces (\(viewModel.featuredListings.count))")
                            .font(.urbanistHeading5.bold())
                        Spacer()
                        Text("See All")
                            .font(.urbanistBodyLarge.bold())
                            .foregroundColor(.urbanPrimary500)
                    }
                    .padding(.trailing, 24)
                    .padding(.top, 24)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()), GridItem(.flexible())
                    ]) {
                        ForEach(viewModel.featuredListings, id: \.id) {
                            FeaturedListingView(image: "office", property: $0, space: $0.spaces.first!)
                        }
                    }
                }
                .padding(.leading, 24)
            }
            .sheet(isPresented: $filtersIsPresented) {
                FiltersView(searchModel: $searchModel)
            }
            NavigationLink(isActive: $showResults) {
                if let filter = searchModel {
                    ResultsView(featuredListings: .mock, results: .mock, filter: filter)
                }
            } label: {
                EmptyView()
            }
        }
        .onChange(of: searchModel) { searchModel in
            guard searchModel != nil else { return }
            filtersIsPresented = false
            DispatchQueue.main.async {
                showResults = true
            }
        }
        .onChange(of: showResults) { showResults in
            guard !showResults else { return }
            searchModel = nil
        }
        .navigationTitle("Explore")
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(viewModel: .init(featuredListings: .mockFeatured))
    }
}
