//
//  AnnotationView12.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView12Info {
    static let identifier = "AnnotationView12"
}

final class AnnotationView12: MKMarkerAnnotationView {

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
        displayPriority      = .defaultHigh
        collisionMode        = .rectangle
        clusteringIdentifier = AnnotationView1Info.identifier
        canShowCallout       = true
        
        titleVisibility      = .visible
        subtitleVisibility   = .adaptive
    }
    
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
        glyphText = (annotation as? PointAnnotation12)?.product?.name
    }
}
