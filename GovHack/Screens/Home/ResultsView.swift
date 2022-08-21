//
//  ResultsView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI
import MapKit

enum ViewType {
    case list
    case map
}

enum ViewState {
    case loading
    case content
    case error
}

struct ResultsView: View {
    @State var featuredListings: [PropertyModel] = []
    @State var results: [PropertyModel] = []
    @State var viewType: ViewType = .list
    @State var viewState: ViewState = .content
    @State var filter: SearchRequestModel
    
    private var searchBar: some View {
        HStack {
            Text("What you searched")
            Spacer()
            Image(systemName: "slider.horizontal.3") 
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
    }
    
    private var listView: some View {
        VStack(alignment: .leading) {
            Text("Highlighted Listings")
                .padding(.horizontal, 16)
            FeaturedListingsCarouselView(featuredListings: featuredListings)
            
            ForEach(results, id: \.id) {
                ListingView(property: $0, spaceTypes: filter.spaceNames ?? [])
            }.padding(.horizontal, 16)
        }
    }
    
    private func mapView(size: CGSize) -> some View {
        NormalMapView(
            places: results.map({
                .init(propertyId: $0.id, coordinate: .init(latitude: .init($0.location.latitude), longitude: .init($0.location.longitude)))
            }),
            selectedPlace: .constant(nil),
            displayedRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400))
        )
        .frame(width: size.width, height: size.height)
    }
    
    private var contentView: some View {
        GeometryReader { proxy in
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
                    
                    if viewType == .list {
                        listView
                    } else {
                        mapView(size: proxy.size)
                    }
                }
            }
        }
    }
    
    var body: some View {
        Group {
            switch viewState {
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .content: contentView
            case .error: Text("Something went wrong")
            }
        }.navigationTitle("Results")
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(featuredListings: .mockFeatured, results: .mock, filter: .init(lat: 0, long: 0, radius: 0, maxPrice: nil, includedFacilities: nil, spaceNames: [.desk, .boardroom], capacity: nil))
    }
}
