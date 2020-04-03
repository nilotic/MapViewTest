//
//  PointAnnotation6Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation6Info {
    static let identifier = "PointAnnotation6"
}

final class PointAnnotation6: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel6

    
    
    // MARK: - Intializer
    init(data: Hotel6) {
        product = data
        super.init()
        
        title    = data.name
        subtitle = data.price.koreanCurrency
        
        guard let location = data.location else { return }
        coordinate = location.coordinate
    }
}
