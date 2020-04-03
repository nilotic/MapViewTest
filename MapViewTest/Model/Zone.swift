//
//  Zone.swift
//  MapViewTest
//
//  Created by Den Jo on 2020/04/03.
//  Copyright © 2020 Den Jo. All rights reserved.
//

import MapKit

struct Zone {
    let title: String?
    let subtitle: String?
    let fillColor: UIColor?
    let strokeColor: UIColor?
    let lineWidth: CGFloat
    let location: CLLocation?
}

extension Zone {
    
    init(data: FeatureProperties, coordinate: CLLocationCoordinate2D) {
        title       = data.title
        subtitle    = data.subtitle
        fillColor   = data.fillColor
        strokeColor = data.strokeColor
        lineWidth   = data.lineWidth
        location    = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
