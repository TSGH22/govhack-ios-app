//
//  MapCoordinator.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation
import MapKit

extension NormalMapView {

    class Coordinator: NSObject, MKMapViewDelegate {

        var parent: NormalMapView
        var places: [MapLocation] = []

        init(_ parent: NormalMapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {

        }

        //        func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        //            let cluster = MKClusterAnnotation(memberAnnotations: mapView.annotations)
        //            print(cluster.memberAnnotations.count)
        //            return cluster
        //        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation as? MapLocationAnnotation else { return }
            parent.selectedPlace = annotation.location
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            return MapPin(annotation: annotation, reuseIdentifier: "MyMarker")
        }

        func update(map: MKMapView, places: [MapLocation]) {
            print("[Map] Showing:", places)
            map.removeAnnotations(map.annotations)
            map.addAnnotations(places.map(\.annotation))
            zoomMapaFitAnnotations(mapview: map)
        }

        // https://stackoverflow.com/a/45557164
        func zoomMapaFitAnnotations(mapview: MKMapView) {
            guard !mapview.annotations.isEmpty else { return }
            var zoomRect = MKMapRect.null
            for annotation in mapview.annotations {

                let annotationPoint = MKMapPoint(annotation.coordinate)

                let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)

                if (zoomRect.isNull) {
                    zoomRect = pointRect
                } else {
                    zoomRect = zoomRect.union(pointRect)
                }
            }
            mapview.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        }

    }

}
