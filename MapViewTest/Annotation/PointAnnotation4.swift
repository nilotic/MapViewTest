//
//  PointAnnotation4Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation4Info {
    static let identifier = "PointAnnotation4"
}

final class PointAnnotation4: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel4

    
    
    // MARK: - Intializer
    init(data: Hotel4) {
        product = data
        super.init()
        
        title    = data.name
        subtitle = data.price.koreanCurrency
        
        guard let location = data.location else { return }
        coordinate = location.coordinate
    }
}
