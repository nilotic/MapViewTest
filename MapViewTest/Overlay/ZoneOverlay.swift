//
//  ZoneOverlay.swift
//  MapViewTest
//
//  Created by Den Jo on 2020/04/03.
//  Copyright © 2020 Den Jo. All rights reserved.
//

import UIKit
import MapKit

final class ZoneOverlay: MKPolygon {

    // MARK: - Value
    // MARK: Public
    var fillColor: UIColor?   = nil
    var strokeColor: UIColor? = nil
    var lineWidth: CGFloat    = 0
    

    
    // MARK: - Initializer
    convenience init(data: MKPolygon, properties: FeatureProperties) {
        self.init(points: data.points(), count: data.pointCount)
        
        title       = data.title
        subtitle    = data.subtitle
        fillColor   = properties.fillColor
        strokeColor = properties.strokeColor
        lineWidth   = properties.lineWidth
    }
}
