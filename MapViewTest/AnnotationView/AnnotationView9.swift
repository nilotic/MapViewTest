//
//  AnnotationView9.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

// MARK: - Define
struct AnnotationView9Info {
    static let identifier = "AnnotationView9"
}


final class AnnotationView9: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }
    
    // MARK: Private
    private lazy var detailButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.frame = CGRect(x: 0, y: 0, width: 30.0, height: 30.0)
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
        if #available(iOS 11.0, *) {
            collisionMode        = .rectangle
            clusteringIdentifier = AnnotationView1Info.identifier
        }
        canShowCallout = true
        image = #imageLiteral(resourceName: "pin09").resizedImage(size: CGSize(width: #imageLiteral(resourceName: "pin09").size.width/4.0, height: #imageLiteral(resourceName: "pin09").size.height/4.0), scale: 1.0)
        rightCalloutAccessoryView = detailButton
    }
    
    
    private func update(annotation: MKAnnotation?) {
        if #available(iOS 11.0, *) {
            clusteringIdentifier = AnnotationView1Info.identifier
        }
        
        guard let annotation = annotation as? PointAnnotation9 else { return }
        let hotel1 = Hotel1(index: annotation.product.index, name: annotation.product.name, price: annotation.product.price, imageURL: annotation.product.imageURL, location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
        
        guard let view = Bundle.main.loadNibNamed(DetailCalloutAccessoryView1Info.identifier, owner: self, options: nil)?.first as? DetailCalloutAccessoryView1 else { return }
        view.update(data: PointAnnotation1(data: hotel1))
        
        detailCalloutAccessoryView = view
    }
}





