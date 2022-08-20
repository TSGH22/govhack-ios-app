//
//  MapPin.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import MapKit

class MapPin: MKAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            image = UIImage(named: "Location")
        }
    }

}
