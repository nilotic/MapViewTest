//
//  DetailCalloutAccessoryView1.swift
//  MapViewTest
//
//  Created by Den Jo on 25/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit

// MARK: - Define
struct DetailCalloutAccessoryView1Info {
    static let identifier = "DetailCalloutAccessoryView1"
}

final class DetailCalloutAccessoryView1: UIView {

    // MARK: - IBOutlet
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    
    
    // MARK: - Function
    // MARK: Public
    func update(data: PointAnnotation1?) {
        guard let product = data?.product else { return }
        
        titleLabel.text = product.name
        subTitleLabel.text = product.price.koreanCurrency
        
        guard let url = product.imageURL else { return }
        DispatchQueue.global().async {
            do {
                guard let image = UIImage(data: try Data(contentsOf: url, options: .mappedIfSafe)) else { return }
                DispatchQueue.main.async { self.imageView.image = image }
            } catch {}
        }
    }
        
}
