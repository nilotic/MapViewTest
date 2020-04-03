//
//  PointAnnotation15Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation15Info {
    static let identifier = "PointAnnotation15"
}

final class PointAnnotation15: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel15

    
    
    // MARK: - Intializer
    init(data: Hotel15) {
        product = data
        super.init()
        
        title    = data.name
        subtitle = data.price.koreanCurrency
        
        guard let location = data.location else { return }
        coordinate = location.coordinate
    }
}
