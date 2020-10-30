//
//  PointAnnotation10Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation10Info {
    static let identifier = "PointAnnotation10"
}


final class PointAnnotation10: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel10
    
    
    // MARK: - Intializer
    init(data: Hotel10) {
        product = data
        super.init()
        
        title    = product.name
        subtitle = product.price.koreanCurrency
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
