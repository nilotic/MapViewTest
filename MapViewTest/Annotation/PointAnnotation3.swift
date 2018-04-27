//
//  PointAnnotation3Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation3Info {
    static let identifier = "PointAnnotation3"
}


final class PointAnnotation3: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel3
    
    
    // MARK: - Intializer
    init(data: Hotel3) {
        product = data
        super.init()
        
        title    = product.name
        subtitle = product.price.koreanCurrency
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
