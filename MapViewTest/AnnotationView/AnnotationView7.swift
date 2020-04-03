//
//  AnnotationView7.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView7Info {
    static let identifier = "AnnotationView7"
}

final class AnnotationView7: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    // MARK: Private
    private lazy var overlayButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: 30.0))
        button.setImage(#imageLiteral(resourceName: "DailyHotelLogo"), for: .normal)
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
        
        image = #imageLiteral(resourceName: "pin07").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin07").size.width/4.0, height: #imageLiteral(resourceName: "pin07").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = overlayButton
    }
    
    private func update(annotation: MKAnnotation?) {
        clusteringIdentifier = AnnotationView1Info.identifier
        
        guard let annotation = annotation as? PointAnnotation7 else { return }
    }
}
