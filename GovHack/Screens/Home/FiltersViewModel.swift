//
//  FiltersViewModel.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation
import CoreLocation
import Combine
import Contacts
import MapKit

class FiltersViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var resolvedLocation: String = ""
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400)
    var cancellables: Set<AnyCancellable> = []
    var forceStopGeocoding = false

    private let geocoder = CLGeocoder()

    init() {
        setup()
    }

    func forceDisplay(search: String) {
        searchText = resolvedLocation
        forceStopGeocoding = true
        resolvedLocation = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.forceStopGeocoding = false
        }
    }

}


extension FiltersViewModel {

    func setup() {
        $searchText
            .filter { [weak self] in $0 != self?.resolvedLocation }
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.reverseGeocode(searchText: value)
            }
            .store(in: &cancellables)
    }

    func reverseGeocode(searchText: String) {
        guard !forceStopGeocoding && searchText.count > 3 else {
            reset()
            return
        }
        geocoder.cancelGeocode()

        let address = CNMutablePostalAddress()
        address.city = searchText
        address.country = "Australia"

        geocoder.geocodePostalAddress(address) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard let placemark = placemarks?.first else {
                    self?.reset()
                    return
                }
                print("[CLGeocoder]", placemark)
                guard let a = placemark.locality, let b = placemark.subAdministrativeArea, let c = placemark.administrativeArea else {
                    self?.reset()
                    return
                }
                self?.resolvedLocation = "\(a), \(b), \(c)"
            }
        }
    }

    func reset() {
        resolvedLocation = ""
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400)
    }

}
