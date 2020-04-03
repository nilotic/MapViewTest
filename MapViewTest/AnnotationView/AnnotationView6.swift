//
//  AnnotationView6.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView6Info {
    static let identifier = "AnnotationView6"
}

final class AnnotationView6: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    // MARK: Private
    private lazy var overlayButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: 30.0))
        button.setImage(#imageLiteral(resourceName: "overlayIcon"), for: .normal)
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
        collisionMode        = .rectangle
        clusteringIdentifier = AnnotationView1Info.identifier
        canShowCallout       = true
        
        image = #imageLiteral(resourceName: "pin06").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin06").size.width/4.0, height: #imageLiteral(resourceName: "pin06").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = overlayButton
    }

    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
