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
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30))
            image = renderer.image { _ in
                UIColor.orange.setFill()
                UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 30, height: 30)).fill()
            }
        }
    }

}
