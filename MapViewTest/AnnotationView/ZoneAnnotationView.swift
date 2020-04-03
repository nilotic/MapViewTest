//
//  ZoneAnnotationView.swift
//  MapViewTest
//
//  Created by Den Jo on 2020/04/03.
//  Copyright © 2020 Den Jo. All rights reserved.
//

import MapKit

// MARK: - Define
struct ZoneAnnotationViewInfo {
    static let identifier = "ZoneAnnotationView"
}

final class ZoneAnnotationView: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet { update(annotation: newValue) }
    }

    
    // MARK: Private
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive           = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive   = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive     = true
        return label
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
        displayPriority = .defaultHigh
        collisionMode   = .rectangle
        canShowCallout  = false
    }
    
    private func update(annotation: MKAnnotation?) {
        guard let title = annotation?.title else { return }
        label.text = title
    }
}
