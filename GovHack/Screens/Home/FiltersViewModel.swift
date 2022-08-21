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

    @Published var facLifts: Bool = false
    @Published var facShowers: Bool = false
    @Published var facMonitors: Bool = false
    @Published var facStandingDesks: Bool = false
    @Published var facKitchen: Bool = false
    @Published var facToilet: Bool = false
    @Published var facWhiteboard: Bool = false
    @Published var facProjector: Bool = false
    @Published var facAccessibleAccess: Bool = false
    @Published var facParking: Bool = false
    @Published var facAircon: Bool = false
    @Published var facContactlessAccess: Bool = true
    @Published var facOfficeManagerAccess: Bool = true
    @Published var facWifi: Bool = false
    @Published var showNearbyAreas: Bool = false
    @Published var spaceDesk: Bool = false
    @Published var spaceStudio: Bool = false
    @Published var spaceMeetingRoom: Bool = false
    @Published var spaceAll: Bool = true
    @Published var spaceWholeOffice: Bool = false

    @Published var dateFrom: Date?
    @Published var dateTo: Date?
    @Published var dateFromString: String = ""
    @Published var dateToString: String = ""

    @Published var numberOfPeopleField: String = ""
    @Published var customMessageField: String = ""

    @Published var currentPage = 0

    @Published var privacyAny: Bool = true
    @Published var privacyShared: Bool = false
    @Published var privacyPrivate: Bool = false

    @Published var ratingAll: Bool = true
    @Published var rating1: Bool = false
    @Published var rating2: Bool = false
    @Published var rating3: Bool = false
    @Published var rating4: Bool = false
    @Published var rating5: Bool = false

    @Published var priceRangeSlider: ClosedRange<Float> = 20...100
    @Published var backButtonVisible: Bool = false
    @Published var nextButtonTitle = "Next"

    private let geocoder = CLGeocoder()

    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()

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

    func goBack() {
        guard currentPage > 0 else { return }
        currentPage -= 1
        updateNextButtonTitle()
    }

    func goNext() {
        if currentPage == 2 {
            // TODO: push results please
        } else {
            currentPage += 1
        }
        updateNextButtonTitle()
    }

    func updateNextButtonTitle() {
        if currentPage == 2 {
            nextButtonTitle = "Find Spaces"
        } else {
            nextButtonTitle = "Next"
        }
        backButtonVisible = currentPage > 0
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

        // I was in a hurry
        $spaceAll.sink { [weak self] isOn in
            guard isOn else { return }
            self?.spaceDesk = false
            self?.spaceStudio = false
            self?.spaceMeetingRoom = false
            self?.spaceWholeOffice = false
        }
        .store(in: &cancellables)
        $spaceDesk.sink { [weak self] isOn in
            guard isOn else { return }
            self?.spaceAll = false
        }
        .store(in: &cancellables)
        $spaceStudio.sink { [weak self] isOn in
            guard isOn else { return }
            self?.spaceAll = false
        }
        .store(in: &cancellables)
        $spaceMeetingRoom.sink { [weak self] isOn in
            guard isOn else { return }
            self?.spaceAll = false
        }
        .store(in: &cancellables)
        $spaceWholeOffice.sink { [weak self] isOn in
            guard isOn else { return }
            self?.spaceAll = false
        }
        .store(in: &cancellables)

        $ratingAll.sink { [weak self] isOn in
            guard isOn else { return }
            self?.rating1 = false
            self?.rating2 = false
            self?.rating3 = false
            self?.rating4 = false
            self?.rating5 = false
        }
        .store(in: &cancellables)
        $rating1.sink { [weak self] isOn in
            guard isOn else { return }
            self?.ratingAll = false
        }
        .store(in: &cancellables)
        $rating2.sink { [weak self] isOn in
            guard isOn else { return }
            self?.ratingAll = false
        }
        .store(in: &cancellables)
        $rating3.sink { [weak self] isOn in
            guard isOn else { return }
            self?.ratingAll = false
        }
        .store(in: &cancellables)
        $rating4.sink { [weak self] isOn in
            guard isOn else { return }
            self?.ratingAll = false
        }
        .store(in: &cancellables)
        $rating5.sink { [weak self] isOn in
            guard isOn else { return }
            self?.ratingAll = false
        }
        .store(in: &cancellables)


        $dateTo.sink { [weak self] date in
            guard let date = date else { return }
            self?.dateToString = self?.dateFormatter.string(from: date) ?? ""
        }
        .store(in: &cancellables)
        $dateFrom.sink { [weak self] date in
            guard let date = date else { return }
            self?.dateFromString = self?.dateFormatter.string(from: date) ?? ""
        }
        .store(in: &cancellables)

        $privacyAny.sink { [weak self] isOn in
            guard isOn else { return }
            self?.privacyShared = false
            self?.privacyPrivate = false
        }
        .store(in: &cancellables)
        $privacyShared.sink { [weak self] isOn in
            guard isOn else { return }
            self?.privacyAny = false
            self?.privacyPrivate = false
        }
        .store(in: &cancellables)
        $privacyPrivate.sink { [weak self] isOn in
            guard isOn else { return }
            self?.privacyShared = false
            self?.privacyAny = false
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
