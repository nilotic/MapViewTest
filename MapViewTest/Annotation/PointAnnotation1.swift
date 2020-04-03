//
//  PointAnnotation1Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation1Info {
    static let identifier = "PointAnnotation1"
}

final class PointAnnotation1: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel1?
    
 
    
    // MARK: - Intializer
    init(data: Hotel1) {
        product = data
        super.init()
        
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
