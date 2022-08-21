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

    init() {
        self.selectedPlace = nil
    }
    
    private var searchView: some View {
        VStack {
            Text("Tell us what you need")
                .padding(16)
                .frame(maxWidth: .infinity)
            
        }
        .background(Color.gray)
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
                Group {
                    Text("Search")
                    searchView.padding(.trailing, 16)
                    Divider()
                    Text("Map View")
                    NormalMapView(
                        places: viewModel.mapPlaces,
                        selectedPlace: $selectedPlace,
                        displayedRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400))
                    )
                    .frame(height: 150)
                    .padding(.trailing, 16)
                    Divider()
                    Text("Featured")
                }
                .padding(.leading, 16)
                FeaturedListingsCarouselView(featuredListings: viewModel.featuredListings)
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
        ExploreView()
    }
}
