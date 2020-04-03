//
//  PointAnnotation2Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation2Info {
    static let identifier = "PointAnnotation2"
}

final class PointAnnotation2: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel2?

    
    
    // MARK: - Intializer
    init(data: Hotel2) {
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
