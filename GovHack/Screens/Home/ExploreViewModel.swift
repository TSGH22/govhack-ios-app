//
//  ExploreViewModel.swift
//  Spacey
//
//  Created by Max Chuquimia on 21/8/2022.
//

import Foundation
import Combine
import MapKit

final class ExploreViewModel: ObservableObject {

    @Published var featuredListings: [PropertyModel] = []
    @Published var mapPlaces: [MapLocation] = []

    init(featuredListings: [PropertyModel] = [], mapPlaces: [MapLocation] = []) {
        self.featuredListings = featuredListings
        self.mapPlaces = mapPlaces
    }
    
    func loadContent() {
        API.shared.fetchFeaturedProperties { [weak self] result in
            switch result {
            case let .success(models):
                self?.featuredListings = models
                self?.mapPlaces = models.map({ prop in
                    MapLocation(propertyId: prop.id, coordinate: CLLocationCoordinate2D(latitude: prop.location.latitude, longitude: prop.location.longitude))
                })
            case let .failure(error):
                print(error)
            }
        }
    }

}
