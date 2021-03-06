//
//  AnnotationView11.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView11Info {
    static let identifier = "AnnotationView11"
}


@available(iOS 11.0, *)
final class AnnotationView11: MKMarkerAnnotationView {

    // MARK: - Initializer
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    
    
    // MARK: - Function
    // MARK: Private
    private func setView() {
        displayPriority      = .defaultHigh
        collisionMode        = .rectangle
        clusteringIdentifier = AnnotationView1Info.identifier
        canShowCallout       = true
        
        markerTintColor    = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        glyphImage         = #imageLiteral(resourceName: "DailyHotelLogo")
        glyphTintColor     = #colorLiteral(red: 0.7176470588, green: 0, blue: 0.2196078431, alpha: 1)
        titleVisibility    = .visible
        subtitleVisibility = .visible
    }
    
    
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}





