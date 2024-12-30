//
//  PlaceAnnotation.swift
//  nlw
//
//  Created by Niceplanet T.I on 23/12/24.
//
import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(place: Place){
        self.title = place.name
        self.subtitle = place.description
        self.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }
}
