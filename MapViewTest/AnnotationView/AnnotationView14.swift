//
//  AnnotationView14.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView14Info {
    static let identifier = "AnnotationView14"
}

final class AnnotationView14: MKAnnotationView {

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
        canShowCallout       = true
        
        image = #imageLiteral(resourceName: "pin14").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin14").size.width/4.0, height: #imageLiteral(resourceName: "pin14").size.height/4.0), scale: 1.0)
    }
    
    private func update() {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
