//
//  PointAnnotation12Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation12Info {
    static let identifier = "PointAnnotation12"
}


final class PointAnnotation12: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel12
    
    
    // MARK: - Intializer
    init(data: Hotel12) {
        product = data
        super.init()
        
        title = product.price.koreanCurrency
        subtitle = "⭐️⭐️⭐️⭐️⭐️"
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
