//
//  DataManager.swift
//  MapViewTest
//
//  Created by Den Jo on 25/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit
import MapKit

final class DataManager: NSObject {

    // MARK: - Value
    // MARK: Public
    private(set) var annotations = [MKAnnotation]()
    var overlays = [MKOverlay]()
    
    
    
    
    // MARK: - Function
    // MARK: Public
    func requestProducts() -> Bool {
        var location: CLLocation {
            let latitude  = 35.995572 + CLLocationDegrees(arc4random_uniform(UInt32(3049579))) / CLLocationDegrees(10000000)
            let longitude = -(115.099827 + (CLLocationDegrees(arc4random_uniform(UInt32(2245489))) / CLLocationDegrees(10000000)))
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        let imageURL = URL(string: "https://img.dailyhotel.me/resources/images/noble5234ss/000.jpg")
        
        var price: Double {
            return Double(arc4random_uniform(UInt32(10000000)))
        }
        
        var products = [Product]()
        for i in 0..<170 {
            switch i {
            case 0...9:         products.append(Hotel1(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 10...19:       products.append(Hotel2(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 20...29:       products.append(Hotel3(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 30...39:       products.append(Hotel4(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 40...49:       products.append(Hotel5(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 50...59:       products.append(Hotel6(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 60...69:       products.append(Hotel7(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 70...79:       products.append(Hotel8(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 80...89:       products.append(Hotel9(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 90...99:       products.append(Hotel10(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 100...109:     products.append(Hotel11(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 110...119:     products.append(Hotel12(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 120...129:     products.append(Hotel13(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 130...139:     products.append(Hotel14(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 140...149:     products.append(Hotel15(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            case 150...159:     products.append(Hotel16(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            default:            products.append(Hotel1(index: i, name: "Hotel \(i)", price:  price, imageURL: imageURL, location: location))
            }
        }
        
        for product in products {
            switch product {
            case let data as Hotel1:    annotations.append(PointAnnotation1(data: data))
            case let data as Hotel2:    annotations.append(PointAnnotation2(data: data))
            case let data as Hotel3:    annotations.append(PointAnnotation3(data: data))
            case let data as Hotel4:    annotations.append(PointAnnotation4(data: data))
            case let data as Hotel5:    annotations.append(PointAnnotation5(data: data))
            case let data as Hotel6:    annotations.append(PointAnnotation6(data: data))
            case let data as Hotel7:    annotations.append(PointAnnotation7(data: data))
            case let data as Hotel8:    annotations.append(PointAnnotation8(data: data))
            case let data as Hotel9:    annotations.append(PointAnnotation9(data: data))
            case let data as Hotel10:   annotations.append(PointAnnotation10(data: data))
            case let data as Hotel11:   annotations.append(PointAnnotation11(data: data))
            case let data as Hotel12:   annotations.append(PointAnnotation12(data: data))
            case let data as Hotel13:   annotations.append(PointAnnotation13(data: data))
            case let data as Hotel14:   annotations.append(PointAnnotation14(data: data))
            case let data as Hotel15:   annotations.append(PointAnnotation15(data: data))
            case let data as Hotel16:   annotations.append(PointAnnotation16(data: data))
            default:                    continue
            }
        }
        
        
        // Event zone
        if #available(iOS 13, *), let url = Bundle.main.url(forResource: "event", withExtension: "json") {
            do {
                let eventData = try Data(contentsOf: url)
                let jsonObjects = try MKGeoJSONDecoder().decode(eventData)
                
                
                // Parse
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                for object in jsonObjects {
                    guard let feature = object as? MKGeoJSONFeature else { continue }
                    
                    for geometry in feature.geometry {
                        guard let propertyData = feature.properties, let properties = try? decoder.decode(FeatureProperties.self, from: propertyData) else { continue }
                            
                        switch geometry {
                        case let data as MKPolygon:
                            overlays.append(ZoneOverlay(data: data, properties: properties))
                            annotations.append(ZoneAnnotation(data: properties, coordinate: data.coordinate))
                            
                        case let data as MKPointAnnotation:
                            switch properties.type {
                            case .none:        annotations.append(PointAnnotation7(data: properties, coordinate: data.coordinate))
                            case .bank:        annotations.append(PointAnnotation1(data: properties, coordinate: data.coordinate))
                            case .medical:     annotations.append(PointAnnotation11(data: properties, coordinate: data.coordinate))
                            case .photo:       annotations.append(PointAnnotation3(data: properties, coordinate: data.coordinate))
                            case .event:       annotations.append(PointAnnotation2(data: properties, coordinate: data.coordinate))
                            case .shop:        annotations.append(PointAnnotation12(data: properties, coordinate: data.coordinate))
                            case .information: annotations.append(PointAnnotation14(data: properties, coordinate: data.coordinate))
                            case .zone:        continue
                            }
                            
                        default:
                            continue
                        }
                    }
                }
                
                
            } catch {
                print("Error decoding GeoJSON: \(error).")
            }
        }
        
        return true
    }
}
