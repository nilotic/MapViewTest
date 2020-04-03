//
//  AnnotationView4.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView4Info {
    static let identifier = "AnnotationView4"
}

final class AnnotationView4: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    // MARK: Private
    private lazy var flyOverButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: 30.0))
        button.setImage(#imageLiteral(resourceName: "FlyOverIcon"), for: .normal)
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
        
        image = #imageLiteral(resourceName: "pin04").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin04").size.width/4.0, height: #imageLiteral(resourceName: "pin04").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = flyOverButton
    }
        
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
    }
}
