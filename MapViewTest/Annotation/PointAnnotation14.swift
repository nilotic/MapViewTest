//
//  PointAnnotation14Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation14Info {
    static let identifier = "PointAnnotation14"
}

final class PointAnnotation14: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel14?

    
    
    // MARK: - Intializer
    init(data: Hotel14) {
        product = data
        super.init()
        
        title    = data.name
        subtitle = data.price.koreanCurrency
        
        guard let location = data.location else { return }
        coordinate = location.coordinate
    }
    
    init(data: FeatureProperties, coordinate: CLLocationCoordinate2D) {
        self.product = nil
        super.init()
        
        title    = data.title
        subtitle = data.subtitle
        
        self.coordinate = coordinate
    }
}
