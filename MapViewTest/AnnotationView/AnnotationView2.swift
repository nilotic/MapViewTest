//
//  AnnotationView2.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView2Info {
    static let identifier = "AnnotationView2"
}

final class AnnotationView2: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        didSet { update() }
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
        
        canShowCallout = true
        image = #imageLiteral(resourceName: "pin02").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin02").size.width/4.0, height: #imageLiteral(resourceName: "pin02").size.height/4.0), scale: 1.0)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: frame.height))
        button.setImage(#imageLiteral(resourceName: "navibarIcHeartOnStrokefill"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "navibarIcHeartOnStrokefill"), for: .selected)
        
        leftCalloutAccessoryView = button
        rightCalloutAccessoryView = UIButton(type: .infoLight)
    }
    
    private func update() {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
