//
//  FeatureProperties.swift
//  MapViewTest
//
//  Created by Den Jo on 2020/04/03.
//  Copyright © 2020 Den Jo. All rights reserved.
//

import Foundation
import UIKit

struct FeatureProperties {
    let title: String?
    let subtitle: String?
    let fillColor: UIColor?
    let strokeColor: UIColor?
    let lineWidth: CGFloat
    let type: FeatureType
}

extension FeatureProperties: Decodable {
    
    private enum Key: String, CodingKey {
        case title
        case subtitle
        case fillColor
        case strokeColor
        case lineWidth
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { title       = try container.decode(String.self,      forKey: .title) }             catch { title = nil }
        do { subtitle    = try container.decode(String.self,      forKey: .subtitle) }          catch { subtitle = nil }
        do { fillColor   = try container.decode(String.self,      forKey: .fillColor).color }   catch { fillColor = nil }
        do { strokeColor = try container.decode(String.self,      forKey: .strokeColor).color } catch { strokeColor = nil }
        do { lineWidth   = try container.decode(CGFloat.self,     forKey: .lineWidth) }         catch { lineWidth = 0 }
        do { type        = try container.decode(FeatureType.self, forKey: .type) }              catch { type = .none }
    }
}
