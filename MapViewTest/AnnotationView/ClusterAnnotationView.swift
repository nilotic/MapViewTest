//
//  ClusterAnnotationView.swift
//  dailyhotel
//
//  Created by Den Jo on 6/5/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import MapKit

struct ClusterAnnotationViewInfo {
    static let identifier = "ClusterAnnotationView"
}

final class ClusterAnnotationView: MKAnnotationView {

    // MARK: - Value
    // MARK: Public
    override var annotation: MKAnnotation? {
        willSet (newValue) {
            generateClusterIcon(annotation: newValue)
        }
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
        displayPriority = .required
        collisionMode   = .circle
        canShowCallout = false
        centerOffset   = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    private func generateClusterIcon(annotation: MKAnnotation?) {
        guard let cluster = annotation as? MKClusterAnnotation else { return }
        
        var diameter: CGFloat {
            switch cluster.memberAnnotations.count {
            case 0...4:     return 30.0
            case 5...10:    return 42.0
            case 11...30:   return 55.0
            case 31...99:   return 70.0
            default:        return 90.0
            }
        }
        
        var counts = Array(repeating: UInt(0), count: 16)
        for annotation in cluster.memberAnnotations {
            switch annotation {
            case is PointAnnotation1:   counts[0] += 1
            case is PointAnnotation2:   counts[1] += 1
            case is PointAnnotation3:   counts[2] += 1
            case is PointAnnotation4:   counts[3] += 1
            case is PointAnnotation5:   counts[4] += 1
            case is PointAnnotation6:   counts[5] += 1
            case is PointAnnotation7:   counts[6] += 1
            case is PointAnnotation8:   counts[7] += 1
            case is PointAnnotation9:   counts[8] += 1
            case is PointAnnotation10:  counts[9] += 1
            case is PointAnnotation11:  counts[10] += 1
            case is PointAnnotation12:  counts[11] += 1
            case is PointAnnotation13:  counts[12] += 1
            case is PointAnnotation14:  counts[13] += 1
            case is PointAnnotation15:  counts[14] += 1
            case is PointAnnotation16:  counts[15] += 1
            default:                    continue
            }
        }
        
        let totalCount = counts.reduce(0) { $0 + $1 }
        let palette    = [#colorLiteral(red: 0.9803921569, green: 0.3098039216, blue: 0.5843137255, alpha: 1), #colorLiteral(red: 0, green: 0.5058823529, blue: 0.4431372549, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.2549019608, blue: 0.4784313725, alpha: 1), #colorLiteral(red: 1, green: 0.3921568627, blue: 0.1960784314, alpha: 1), #colorLiteral(red: 0, green: 0.4117647059, blue: 0.3607843137, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3215686275, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.1764705882, green: 0.6588235294, blue: 0.3137254902, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.3098039216, blue: 1, alpha: 1), #colorLiteral(red: 0.768627451, green: 0.3450980392, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.5508370536, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.6941176471, green: 0.6600167411, blue: 0.8860212054, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1), #colorLiteral(red: 0, green: 0.903222084, blue: 0.8049814105, alpha: 1), #colorLiteral(red: 0.2340486944, green: 0.9476005435, blue: 0.4526518583, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
        let size       = CGSize(width: diameter, height: diameter)
        
        image = UIGraphicsImageRenderer(size: size).image { context in
            var isFirst = true
            
            // Fill pie
            var startAngle: CGFloat = 0
            for (i, count) in counts.enumerated() {
                guard 0 < count else { continue }
                guard isFirst == false else {
                    palette[i].setFill()
                    UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
                    isFirst = false
                    continue
                }
                
                palette[i].setFill()
                let piePath = UIBezierPath()
                
                let center   = CGPoint(x: size.width/2.0, y: size.width/2.0)
                let endAngle = startAngle + (CGFloat.pi * 2.0 * CGFloat(count)) / CGFloat(totalCount)
                piePath.addArc(withCenter: center, radius: size.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                piePath.addLine(to: center)
                piePath.close()
                piePath.fill()
                
                // Cache
                startAngle = endAngle
            }
            
            // Fill inner circle with white color
            UIColor.white.setFill()
            let lineWidth = size.width/5.0
            let innerCircleRect = CGRect(x: lineWidth, y: lineWidth, width: size.width - lineWidth*2.0, height: size.height - lineWidth*2.0)
            UIBezierPath(ovalIn: innerCircleRect).fill()
            
            // Finally draw count text vertically and horizontally centered
            let attributes: [NSAttributedString.Key:Any] = [.foregroundColor : UIColor.black,
                                                            .font            : UIFont.boldSystemFont(ofSize: size.width/3.0)]
            
            let text     = "\(totalCount)"
            let textSize = text.size(withAttributes: attributes)
            let rect     = CGRect(x: innerCircleRect.width - (lineWidth/2.0) - textSize.width/2.0, y: innerCircleRect.height - (lineWidth/2.0) - textSize.height/2.0, width: textSize.width, height: textSize.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
