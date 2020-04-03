//
//  DailyOverlayRenderer.swift
//  MapViewTest
//
//  Created by Den Jo on 26/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit
import MapKit

final class DailyOverlayRenderer: MKOverlayRenderer {
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let image = #imageLiteral(resourceName: "DailyHotelLogo").cgImage else { return }
        context.scaleBy(x: 2.0, y: 2.0)
        context.draw(image, in: rect(for: overlay.boundingMapRect))
    }
}
