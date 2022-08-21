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
    
    var searchText: String {
        var text = ""

        text = filter.spaces.map { $0.rawValue }.joined(separator: ", ")

        if let suburb = filter.suburb {
            text += " in \(suburb)"
        }

        return text
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            Text(searchText)
                .font(.urbanistBodySemiboldMedium)
            Spacer()
            Image(systemName: "slider.horizontal.3") 
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.urbanGrey200))
    }
    
    private var listView: some View {
        VStack(alignment: .leading) {
            Text("Highlighted Listings")
                .padding(.horizontal, 24)
                .font(.urbanistHeading6)
            FeaturedListingsCarouselView(featuredListings: featuredListings)
            
            Text("Results")
                .font(.urbanistHeading5.bold())
                .padding(.horizontal, 24)
                .padding(.top, 24)
            LazyVGrid(columns: [
                GridItem(.flexible()), GridItem(.flexible())
            ]) {
                ForEach(results, id: \.id) {
                    FeaturedListingView(image: "office", property: $0, space: $0.spaces.first!, backgroundColor: .white)
                }
            }.padding(.horizontal, 24)
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
                    searchBar.padding(.horizontal, 24)
                    HStack {
                        Text("\(results.count) Results Found")
                            .font(.urbanistHeading5.bold())
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
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
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
        }
        .navigationTitle("Results")
        .onAppear {
            API.shared.searchProperties(request: filter) { result in
                guard case .success(let data) = result else { return }
                print("asdsadasdsdsasdas")
                results = data
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResultsView(featuredListings: .mockFeatured, results: .mock, filter: .init(latitude: 0, longitude: 0, radius: 0, maxPrice: nil, facilities: [:], spaces: [.desk, .boardroom], capacity: nil, suburb: "surry hills"))
        }
    }
}

