//
//  ZoneAnnotation.swift
//  MapViewTest
//
//  Created by Den Jo on 2020/04/03.
//  Copyright © 2020 Den Jo. All rights reserved.
//

import MapKit

// MARK: - Define
struct ZoneAnnotationInfo {
    static let identifier = "ZoneAnnotation"
}

final class ZoneAnnotation: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let fillColor: UIColor?
    let strokeColor: UIColor?
    let lineWidth: CGFloat
    
    
    
    // MARK: - Intializer
    init(data: FeatureProperties, coordinate: CLLocationCoordinate2D) {
        fillColor   = data.fillColor
        strokeColor = data.strokeColor
        lineWidth   = data.lineWidth
        
        super.init()
        
        title           = data.title
        subtitle        = data.subtitle
        self.coordinate = coordinate
    }
}
