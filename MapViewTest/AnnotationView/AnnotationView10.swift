//
//  AnnotationView10.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView10Info {
    static let identifier = "AnnotationView10"
}

final class AnnotationView10: MKMarkerAnnotationView {

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
        displayPriority      = .defaultHigh
        collisionMode        = .rectangle
        clusteringIdentifier = AnnotationView1Info.identifier
        canShowCallout       = true
        glyphImage           = #imageLiteral(resourceName: "DailyHotelLogo")
    }
    
    private func update() {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
