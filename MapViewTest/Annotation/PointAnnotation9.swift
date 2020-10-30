//
//  PointAnnotation9Info.swift
//  dailyhotel
//
//  Created by Den Jo on 04/06/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct PointAnnotation9Info {
    static let identifier = "PointAnnotation9"
}


final class PointAnnotation9: MKPointAnnotation {
    
    // MARK: - Value
    // MARK: Public
    let product: Hotel9
    
    
    // MARK: - Intializer
    init(data: Hotel9) {
        product = data
        super.init()
        
        guard let location = product.location else { return }
        coordinate = location.coordinate
    }
}
