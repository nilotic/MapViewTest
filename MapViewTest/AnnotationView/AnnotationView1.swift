//
//  AnnotationView1.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView1Info {
    static let identifier = "AnnotationView1"
}


final class AnnotationView1: MKAnnotationView {

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
        if #available(iOS 11.0, *) {
            collisionMode        = .rectangle
            clusteringIdentifier = AnnotationView1Info.identifier
        }
        
        canShowCallout = true
        image = #imageLiteral(resourceName: "pin01").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin01").size.width/4.0, height: #imageLiteral(resourceName: "pin01").size.height/4.0), scale: 1.0)
    }
    
    
    private func update(annotation: MKAnnotation?) {
        if #available(iOS 11.0, *) {
            clusteringIdentifier = AnnotationView1Info.identifier
        }
        
        guard let annotation = annotation as? PointAnnotation1 else { return }
        guard let view = Bundle.main.loadNibNamed(DetailCalloutAccessoryView1Info.identifier, owner: self, options: nil)?.first as? DetailCalloutAccessoryView1 else { return }
        view.update(data: annotation)
        detailCalloutAccessoryView = view
    }
}





