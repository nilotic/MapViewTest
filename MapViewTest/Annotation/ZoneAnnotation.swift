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
    let zone: Zone
    
    
    // MARK: - Intializer
    init(data: Zone) {
        zone = data
        super.init()
        
        title    = data.title
        subtitle = data.subtitle
        
        guard let location = data.location else { return }
        coordinate = location.coordinate
    }
}
