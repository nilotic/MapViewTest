//
//  DailyOverlay.swift
//  MapViewTest
//
//  Created by Den Jo on 26/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit
import MapKit

final class DailyOverlay: NSObject, MKOverlay {

    // MARK: - Value
    // MARK: Public
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    
    init(coordinate: CLLocationCoordinate2D, boundingMapRect: MKMapRect) {
        self.coordinate      = coordinate
        self.boundingMapRect = boundingMapRect
    }
}
