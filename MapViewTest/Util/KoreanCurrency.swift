//
//  KoreanCurrency.swift
//  dailyhotel
//
//  Created by Den Jo on 31/12/2017.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import Foundation

// MARK: Int
extension Int {
    var koreanCurrency: String? {
        guard 0 <= self else { return nil }
        
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "ko_KR")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "\(priceString)원"
    }
}

// MARK: UInt
extension UInt {
    var koreanCurrency: String? {
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "ko_KR")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "\(priceString)원"
    }
}

// MARK: Float
extension Float {
    var koreanCurrency: String? {
        guard 0 <= self else { return nil }
        
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "ko_KR")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "\(priceString)원"
    }
    
    var usCurrency: String? {
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "USD \(priceString)"
    }
}

// MARK:  Double
extension Double {
    var koreanCurrency: String? {
        guard 0 <= self else { return nil }
        
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "ko_KR")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "\(priceString)원"
    }
    
    var usCurrency: String? {
        let numberFormatter         = NumberFormatter()
        numberFormatter.locale      = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        
        guard let priceString = numberFormatter.string(from: self as NSNumber) else { return nil }
        return "USD \(priceString)"
    }
}

