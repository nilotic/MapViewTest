//
//  AnnotationView15.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView15Info {
    static let identifier = "AnnotationView15"
}

final class AnnotationView15: MKAnnotationView {

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
        
        image = #imageLiteral(resourceName: "pin15").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin15").size.width/4.0, height: #imageLiteral(resourceName: "pin15").size.height/4.0), scale: 1.0)
    }
    
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
