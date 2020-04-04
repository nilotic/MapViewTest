//
//  AnnotationView5.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView5Info {
    static let identifier = "AnnotationView5"
}

final class AnnotationView5: MKAnnotationView {
    
    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        didSet { update() }
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

        image = #imageLiteral(resourceName: "pin05").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin05").size.width/4.0, height: #imageLiteral(resourceName: "pin05").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = flyOverButton
    }
    
    private func update() {
        clusteringIdentifier = AnnotationView1Info.identifier        

        guard let annotation = annotation as? PointAnnotation5 else { return }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120.0, height: 120.0))
        imageView.contentMode = .scaleAspectFit
        
        let options = MKMapSnapshotter.Options()
        options.size    = imageView.frame.size
        options.mapType = .satelliteFlyover
        options.camera  = MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 10000.0, pitch: 60.0, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { (snapshot, error) in
            guard error == nil else { return }
            imageView.image = snapshot?.image
        }
        
        detailCalloutAccessoryView = imageView
    }
}
