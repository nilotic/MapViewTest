//
//  PointAnnotation16Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation16Info {
    static let identifier = "PointAnnotation16"
}


final class PointAnnotation16: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel16
    
    
    // MARK: - Intializer
    init(data: Hotel16) {
        product = data
        super.init()
        
        title    = product.name
        subtitle = product.price.koreanCurrency
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
