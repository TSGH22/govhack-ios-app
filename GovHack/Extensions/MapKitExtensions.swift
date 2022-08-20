//
//  MapKitExtensions.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation
import CoreLocation
import MapKit

extension CLLocationCoordinate2D : Equatable {

    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}


extension MKCoordinateRegion: Equatable {

    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.span.latitudeDelta == rhs.span.latitudeDelta
        && lhs.span.longitudeDelta == rhs.span.longitudeDelta
        && lhs.center == rhs.center
    }
    
}
