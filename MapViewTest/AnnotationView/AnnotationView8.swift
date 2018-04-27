//
//  AnnotationView8.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView8Info {
    static let identifier = "AnnotationView8"
}


final class AnnotationView8: MKAnnotationView {
    
    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    // MARK: Private
    private lazy var transitButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: 30.0))
        button.setImage(#imageLiteral(resourceName: "TransitIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    
    
    
    
    // MARK: - Initializer
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    
    
    
    
    // MARK: - Function
    // MARK: Private
    private func setView() {
        if #available(iOS 11.0, *) {
            collisionMode        = .rectangle
            clusteringIdentifier = AnnotationView1Info.identifier
        }
        canShowCallout = true
        image = #imageLiteral(resourceName: "pin08").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin08").size.width/4.0, height: #imageLiteral(resourceName: "pin08").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = transitButton
    }
    
    
    private func update(annotation: MKAnnotation?) {
        if #available(iOS 11.0, *) {
            clusteringIdentifier = AnnotationView1Info.identifier
        }
    }
}





