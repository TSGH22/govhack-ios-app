//
//  MapLocation.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation
import MapKit

struct MapLocation {

    let propertyId: String
    let coordinate: CLLocationCoordinate2D

    var annotation: MKAnnotation {
        let a = MapLocationAnnotation()
        a.location = self
        a.coordinate = coordinate
        return a
    }

}

final class MapLocationAnnotation: MKPointAnnotation {
    var location: MapLocation?
}
