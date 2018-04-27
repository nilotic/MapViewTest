//
//  Product.swift
//  MapViewTest
//
//  Created by Den Jo on 25/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit
import MapKit

protocol Product {
    var index: Int { set get }
    var name: String?  { set get }
    var price: Double { set get }
    var imageURL: URL? { set get }
    var location: CLLocation? { set get }
}
