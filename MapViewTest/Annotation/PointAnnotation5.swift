//
//  PointAnnotation5Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation5Info {
    static let identifier = "PointAnnotation5"
}


final class PointAnnotation5: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel5
    
    
    // MARK: - Intializer
    init(data: Hotel5) {
        product = data
        super.init()
        
        title    = product.name
        subtitle = product.price.koreanCurrency
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
