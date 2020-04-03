//
//  AnnotationView13.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView13Info {
    static let identifier = "AnnotationView13"
}

final class AnnotationView13: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    
    
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
        collisionMode        = .rectangle
        clusteringIdentifier = AnnotationView1Info.identifier
        canShowCallout       = true
        
        image = #imageLiteral(resourceName: "pin13").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin13").size.width/4.0, height: #imageLiteral(resourceName: "pin13").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = UIButton(type: .infoLight)
    }
    
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
